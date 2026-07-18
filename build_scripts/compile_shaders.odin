package build

import "core:fmt"
import "core:log"
import "core:os"
import "core:path/filepath"
import "core:strings"
import "core:time"

// ./tools/sokol-shdc.exe -i ./src/shaders/triangle.glsl -o ./src/shaders/out/triangle.odin -f sokol_odin --slang hlsl5

RELATIVE_SOKOL_SHDC_PATH :: "./tools/sokol-shdc.exe"
RELATIVE_SHADER_OUTDIR_PATH :: "./src/shaders/out"
RELATIVE_SHADER_FILES_PATHS :: [?]string{"./src/shaders/triangle.glsl"}
TARGET_COMPILE_LANGUAGES :: "hlsl5"

compile_shaders :: proc() -> int {
	// absolute sokol-shdc.exe path
	sokol_shdc_path, err := os.get_absolute_path(RELATIVE_SOKOL_SHDC_PATH, context.allocator)
	if err != nil {
		log.error("Couldn't resolve sokol-shdc.exe absolute path.")
		log.error(err)
		return 1
	}

	// absolute shader files output dir path
	shader_outdir_path: string
	shader_outdir_path, err = os.get_absolute_path(RELATIVE_SHADER_OUTDIR_PATH, context.allocator)
	if err != nil {
		log.error("Couldn't resolve shader output directory absolute path")
		return 1
	}

	// absolute paths for the shader files
	shader_files_paths: [len(RELATIVE_SHADER_FILES_PATHS)]string
	for path, idx in RELATIVE_SHADER_FILES_PATHS {
		shader_files_paths[idx], err = os.get_absolute_path(path, context.allocator)
		if err != nil {
			log.errorf("Unable to resolve the following shader file path:%s", path)
			log.error(err)
			return 1
		}
	}

	// =============== Setup shader output directory ===============
	info: os.File_Info
	info, err = os.stat(shader_outdir_path, context.allocator)
	if err == nil {
		// directory exists: Clean it
		err = os.remove_all(shader_outdir_path)
		if err != nil {
			log.error("Couldn't delete the existing output directory.")
			log.error(err)
			return 1
		}
	}

	// create fresh shader output directory
	err = os.make_directory_all(shader_outdir_path) // make directory recursive
	if err != nil {
		log.error("Couldn't create fresh output directory.")
		log.error(err)
		return 1
	}

	// =============== Creating the compile shaders command ===============
	log.info("Compiling shaders...")

	// NOTE: sokol-shdc.exe can only compile one shader file at a time
	for shader_path in shader_files_paths {
		compile_cmd: [dynamic]string

		shader_name := strings.split(filepath.base(shader_path), ".")[0]
		shader_name = fmt.tprintf("%s.odin", shader_name)
		out_path, err := filepath.join({shader_outdir_path, shader_name})

		append(
			&compile_cmd,
			sokol_shdc_path,
			"-i",
			shader_path,
			"-o",
			out_path,
			"-f",
			"sokol_odin",
			"--slang",
			TARGET_COMPILE_LANGUAGES,
		)

		// =============== Running the compile shaders command ===============
		compile_cmd_description: os.Process_Desc = {
			command = compile_cmd[:],
		}
		log.warnf("Shader output target languages are set to: %s", TARGET_COMPILE_LANGUAGES)
		log.infof("Compile command:\n%s", strings.join(compile_cmd[:], " "))

		t := time.now()
		state, stdout, stderr, e := os.process_exec(compile_cmd_description, context.allocator)
		if (state.exit_code > 0) {
			log.error(string(stdout), string(stderr))
			return state.exit_code
		}
		log.infof("Compiled successfully in: %v\n\n", time.diff(t, time.now()))
	}

	return 0
}
