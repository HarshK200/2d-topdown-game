// This build script uses odin version dev-2026-06-nightly:7ab61e4
package build

import "base:runtime"
import "core:fmt"
import "core:log"
import "core:mem"
import "core:mem/virtual"
import "core:os"
import "core:path/filepath"
import "core:strings"
import "core:time"

RELATIVE_SRC_PATH :: "./src" // relative path of src directory to the root of the project i.e. "."
RELATIVE_DEBUG_PATH :: "./build/debug"
RELATIVE_RELEASE_PATH :: "./build/release"
OUTPUT_EXE_NAME :: "main.exe"

main :: proc() {
	start_time := time.now()

	context.logger = log.create_console_logger()
	exit_code: int = run()

	build_time := time.diff(start_time, time.now())
	log.infof("Finished build in TOTAL: %s", build_time)
	os.exit(exit_code)
}

run :: proc() -> int {
	// create a virtual arena, so i don't have to call delete on every single allocation,
	// i allocate an Arena i.e. a chunk of memory at once and delete it at the end of the function
	arena: virtual.Arena
	allocator_err := virtual.arena_init_growing(&arena, 1 * mem.Megabyte)
	if allocator_err != nil {
		log.error("Couldn't initialize arena")
		return 1
	}
	defer virtual.arena_destroy(&arena)
	context.allocator = virtual.arena_allocator(&arena)


	// NOTE: all these paths should be set as absolute paths NOT RELATIVE
	project_path: string
	outdir_path: string
	shader_out_path: string

	build_mode: string
	build_flags: [dynamic]string

	// =============== Parse input arguments ===============

	err: os.Error

	// second argument is the build_mode e.g. --debug
	if len(os.args) < 2 {
		log.error("No build_mode specified.\navailable options are:\n\t--debug\n\t--release")
		return 1
	}
	build_mode = os.args[1]

	// =============== Setup odin build mode and arguments ===============
	switch {
	case build_mode == "--debug":
		outdir_path, err = os.get_absolute_path(RELATIVE_DEBUG_PATH, context.allocator)
		if err != nil {
			log.error("Couldn't resolve output directory absolute path")
			return 1
		}

		append(&build_flags, "-debug")

	case build_mode == "--release":
		outdir_path, err = os.get_absolute_path(RELATIVE_RELEASE_PATH, context.allocator)
		if err != nil {
			log.error("Couldn't resolve output directory absolute path")
			return 1
		}

		append(&build_flags, "-o:speed")
		append(&build_flags, "-no-bounds-check")
		append(&build_flags, "-disable-assert")

	case build_mode == "--shader-only":
		// only compile shaders and return early
		return compile_shaders()

	case:
		log.error("Invalid build mode")
		return 1
	}
	project_path, err = os.get_absolute_path(RELATIVE_SRC_PATH, context.allocator)
	if err != nil {
		log.error("Couldn't resolve project directory absolute path")
		return 1
	}

	// compile shaders
	exit_code := compile_shaders()
	if exit_code != 0 {
		log.error("Error compiling shaders")
		return 1
	}

	// =============== Setup build output directory ===============

	// check if output folder exists
	info: os.File_Info
	info, err = os.stat(outdir_path, context.allocator)

	if err == nil {
		// directory exists: Clean it
		err = os.remove_all(outdir_path)
		if err != nil {
			log.error("Couldn't delete the existing output directory")
			log.error(err)
			return 1
		}
	}
	// Create fresh output build directory
	err = os.make_directory_all(outdir_path) // make directory recursive
	if err != nil {
		log.errorf("Couldn't create output directory.\n%s", outdir_path)
		log.error(err)
		return 1
	}


	// =============== Creating the build command ===============
	log.infof("Build mode: %s", build_mode)

	odin_build_cmd: [dynamic]string

	out_flag: string
	out_flag, err = filepath.join({outdir_path, OUTPUT_EXE_NAME})
	if err != nil {
		log.errorf(
			"Couldn't join outdir_path: %s\nwith\nOutput exe name %s",
			outdir_path,
			OUTPUT_EXE_NAME,
		)
		log.error(err)
		return 1
	}
	out_flag = fmt.tprintf("-out:%s", out_flag)

	append(&odin_build_cmd, "odin", "build", project_path, out_flag)
	append(&odin_build_cmd, ..build_flags[:])

	// =============== Running the build command ===============
	odin_build_desc := os.Process_Desc {
		command = odin_build_cmd[:],
	}
	log.infof("Build command: %s", strings.join(odin_build_cmd[:], " "))

	t := time.now()
	state, stdout, stderr, e := os.process_exec(odin_build_desc, context.allocator)
	if (state.exit_code > 0) {
		log.error(string(stdout), string(stderr))
		return state.exit_code
	}
	log.infof("Build successful in: %v\n\n", time.diff(t, time.now()))

	return 0
}
