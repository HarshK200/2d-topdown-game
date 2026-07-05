package main

import "core:fmt"
import sapp "third_party/sokol/app"

main :: proc() {
	fmt.print("Hello sokol")

	// run sokol app
	sapp.run({window_title = "2d-topdown", width = 800, height = 600, fullscreen = false})
}
