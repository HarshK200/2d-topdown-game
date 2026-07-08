// This build script uses odin version dev-2026-06-nightly:7ab61e4
package build

import "base:runtime"
import "core:fmt"
import "core:log"
import "core:mem"
import "core:mem/virtual"
import "core:os"
import "core:strings"
import "core:time"

RELATIVE_PROJECT_PATH :: "."
RELATIVE_DEBUG_PATH :: "./build/debug"
RELATIVE_RELEASE_PATH :: "./build/release"
RELATIVE_SOKOL_SHDC_EXE_PATH :: "./third_party/sokol/sokol-shdc.exe"
DEFAULT_RELATIVE_SHADER_FILES_PATHS_ARG :: "--shader_files=test.glsl"

main :: proc() {
	context.logger = log.create_console_logger()

	start_time := time.now()
	exit_code: int = run()
	build_time := time.diff(start_time, time.now())
	log.infof("Finished build in: %s", build_time)

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

	err: os.Error

	// NOTE: all these paths are absolute paths
	project_path: string
	outdir_path: string
	sokol_shdc_path: string
	shader_files_paths: []string

	build_mode: string
	build_flags: [dynamic]string

	// second argument is the build_mode e.g. --debug
	if len(os.args) < 2 {
		log.error("No build_mode specified.\navailable options are:\n\t--debug\n\t--release")
		return 1
	}
	// third argument is the shaderfiles e.g. --shader_files=shaders/myshader.glsl
	if len(os.args) > 3 {
		shader_files_paths = parse_shader_files_arg(os.args[2])
	}

	// Setup input arguments (NOTE: os.args[0] is the executable path. custom args start from index 1)
	build_mode = os.args[1]
	project_path, err = os.get_absolute_path(RELATIVE_PROJECT_PATH, context.allocator)
	if err != nil {
		log.error("Couldn't resolve project directory absolute path")
		return 1
	}

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

	case:
		log.error("Invalid build mode")
		return 1
	}

	// setup sokol shdc path
	sokol_shdc_path, err = os.get_absolute_path(RELATIVE_SOKOL_SHDC_EXE_PATH, context.allocator)
	if err != nil {
		log.error("Couldn't resolve sokol-shdc.exe absolute path")
		return 1
	}

	// check if output folder exists
	info: os.File_Info
	info, err = os.stat(outdir_path, context.allocator)

	if err == nil {
		// directory exists: Clean it
		log.warn("Output build directory already exists")
		log.infof("Removing dir: %s", outdir_path)
		err = os.remove_all(outdir_path)
		if err != nil {
			log.error("Couldn't delete the existing output directory")
			log.error(err)
			return 1
		}
	}
	// Create fresh output build directory
	log.infof("Creating ouput build directory at %s", outdir_path)
	err = os.make_directory_all(outdir_path) // make directory recursive
	if err != nil {
		log.errorf("Couldn't create output directory.\n%s", outdir_path)
		log.error(err)
		return 1
	}


	// Creating the build command
	log.infof("Build mode: %s", build_mode)
	log.info("Building...\n")

	out_flag := fmt.tprintf("-out:%s/main.exe", outdir_path)
	cmd: [dynamic]string

	append(&cmd, "odin", "build", project_path, out_flag)
	for flag in build_flags {
		append(&cmd, flag)
	}

	// Running the build command
	desc := os.Process_Desc {
		command = cmd[:],
	}
	state, stdout, stderr, e := os.process_exec(desc, context.allocator)
	if (state.exit_code > 0) {
		log.error(string(stdout), string(stderr))
	}

	// TODO: Compile files from --shader_files argument using sokol-shdc

	return 0
}

// NOTE - expects shaderfiles_arg to look like: --shader_files=shaders/example1.glsl,shaders/example2.glsl,shaders/example3.glsl
// where shaders/example1.glsl is path of the shader file relative to the process path, NOT the build executable path
parse_shader_files_arg :: proc(shader_files_args: string) -> []string {
	raw_shaderfiles_paths: []string = strings.split(strings.split(shader_files_args, "=")[1], ",")

	// TODO: loop through all the file paths and convert them to absolute paths by using os.get_absolute_path()
	return raw_shaderfiles_paths
}
