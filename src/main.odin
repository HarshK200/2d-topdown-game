package main

import sapp "../third_party/sokol/app"
import sg "../third_party/sokol/gfx"
import sglue "../third_party/sokol/glue"
import slog "../third_party/sokol/log"
import "base:runtime"
import "core:log"
import "core:mem"
import "core:mem/virtual"

main :: proc() {
	context = runtime.default_context()
	context.logger = log.create_console_logger()

	log.info("Hello sokol + odin")

	sapp.run(
		{
			init_cb = init,
			frame_cb = frame,
			cleanup_cb = cleanup,
			width = 1280,
			height = 720,
			fullscreen = false,
			window_title = "2d-topdown-game",
			icon = {sokol_default = true},
			logger = {func = slog.func},
		},
	)
}

init :: proc "c" () {
	// Memory management stuff
	context = runtime.default_context()
	context.logger = log.create_console_logger()
	init_arena: virtual.Arena
	err := virtual.arena_init_growing(&init_arena, 1 * mem.Megabyte)
	if err != nil {
		log.error("Couldn't initialize the arena for init function")
		return
	}
	context.allocator = virtual.arena_allocator(&init_arena)

	// setup device sokol sfx environment for platform specific graphics API like DirectX, OpenGL, etc
	sg.setup({environment = sglue.environment(), logger = {func = slog.func}})

	// odinfmt: disable
	vertices:= [?]f32 {
		// position
		 0.0,  0.5, 0.0,
		 0.5, -0.5, 0.0,
		-0.5, -0.5, 0.0
	}
	// odinfmt: enable

	vertex_buffer := sg.make_buffer(
		{
			usage = {vertex_buffer = true, immutable = true},
			data = {ptr = &vertices, size = size_of(vertices)},
			label = "Triangle vertices buffer",
		},
	)
}

frame :: proc "c" () {
	sg.begin_pass({swapchain = sglue.swapchain()})
	sg.end_pass()
	sg.commit()
}

cleanup :: proc "c" () {
	context = runtime.default_context()
	sg.shutdown()
}
