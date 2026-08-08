package utils

import "core:os"
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
