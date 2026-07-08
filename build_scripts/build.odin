package build

import "base:runtime"
import "core:fmt"
import "core:log"
import "core:os"
import "core:time"

TEMP_BUILD_FILES_PATH :: "./build"

main :: proc() {
	context.logger = log.create_console_logger()

	start_time := time.now()

	exit_code: int = run()

	build_time := time.diff(start_time, time.now())
	log.infof("Finished build in: %s", build_time)

	os.exit(exit_code)
}

run :: proc() -> int {
	err: os.Error

	build_mode: string
	project_path: string
	outdir_path: string
	sokol_shdc_path: string

	build_flags: [dynamic]string
	defer delete(build_flags)

	if len(os.args) < 2 {
		log.error("No build_mode specified.\navailable options are:\n\t--debug\n\t--release")
		return 1
	} else {
		build_mode = os.args[1]
	}

	project_path, err = os.get_absolute_path(".", context.allocator)
	if err != nil {panic("Couldn't resolve project directory absolute path")}

	switch {
	case build_mode == "--debug":
		outdir_path, err = os.get_absolute_path("./build/debug", context.allocator)
		if err != nil {panic("Couldn't resolve output directory absolute path")}

		append(&build_flags, "-debug")

	case build_mode == "--release":
		outdir_path, err = os.get_absolute_path("./build/release", context.allocator)
		if err != nil {panic("Couldn't resolve output directory absolute path")}

		append(&build_flags, "-o:speed")
		append(&build_flags, "-no-bounds-check")
		append(&build_flags, "-disable-assert")

	case:
		log.error("Invalid build mode")
		return 1
	}

	sokol_shdc_path, err = os.get_absolute_path(
		"./third_party/sokol/sokol-shdc.exe",
		context.allocator,
	)
	if err != nil {panic("Couldn't resolve sokol-shdc.exe absolute path")}

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
	defer os.file_info_delete(info, context.allocator)


	// Creating the build command
	log.infof("Build mode: %s", build_mode)
	log.info("Building...\n")

	out_flag := fmt.tprintf("-out:%s/main.exe", outdir_path)
	cmd: [dynamic]string
	defer delete(cmd)

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
	delete(stdout)
	delete(stderr)

	return 0
}
