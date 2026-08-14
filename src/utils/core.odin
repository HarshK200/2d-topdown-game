package utils

import "core:os"
import gmath "topdown_game:internal/game_math"
import "topdown_game:internal/logger"

// this loads an image using odin's core:os and retuns the file data slice
// Uses context.temp_allocator to allocate
load_image_file :: proc(img_path: string) -> []byte {
	// get absolute path
	abs_path, err := os.get_absolute_path(img_path, context.temp_allocator)
	if err != nil {
		logger.errorf("Couldn't resolve image file path: %s", img_path)
		return nil
	}
	// check if file is valid
	info: os.File_Info
	info, err = os.stat(abs_path, context.temp_allocator)
	if err != nil {
		logger.errorf("Couldn't find file with path: %s", abs_path)
		return nil
	}

	// read the file
	fdata: []byte
	fdata, err = os.read_entire_file(abs_path, context.temp_allocator)
	if err != nil {
		logger.errorf("Error reading file with path: %s ", img_path)
		return nil
	}

	return fdata
}

// converts any screen space xy coordinates to ndc i.e. -1.0 to +1.0
// NOTE: Screen space coords are +Y "Down"
// and converted NDC coords are +Y "Up", which is the convention in both DirexX and OpenGL *nobody cares about vulkan*
screen_to_ndc :: proc(pos: gmath.vec2, screen_size: gmath.vec2) -> gmath.vec2 {
	return {(pos.x / screen_size.x) * 2.0 - 1.0, 1.0 - (pos.y / screen_size.y) * 2.0}
}
