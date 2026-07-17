package main

import sapp "../third_party/sokol/app"
import sg "../third_party/sokol/gfx"
import sglue "../third_party/sokol/glue"
import slog "../third_party/sokol/log"
import "./shaders"
import "base:runtime"
import "core:log"

default_context := runtime.default_context()
GameState :: struct {
	vertex_buffer: sg.Buffer,
	pipeline:      sg.Pipeline,
	pass_action:   sg.Pass_Action,
}

state: GameState

main :: proc() {
	context = default_context
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
	context = default_context

	// setup device sokol sfx environment for platform specific graphics API like DirectX, OpenGL, etc
	sg.setup({environment = sglue.environment(), logger = {func = slog.func}})

	// odinfmt: disable
	// vertex buffer
	vertices:= [?]f32 {
		// position
		 0.0,  0.5, 0.0,
		 0.5, -0.5, 0.0,
		-0.5, -0.5, 0.0
	}
	// odinfmt: enable

	// upload vertex buffer data from RAM to GPU VRAM
	state.vertex_buffer = sg.make_buffer(
		{
			usage = {vertex_buffer = true, immutable = true},
			data = {ptr = &vertices, size = size_of(vertices)},
			label = "Triangle vertices buffer",
		},
	)

	// load and compile shader
	shader := sg.make_shader(shaders.main_shader_desc(sg.query_backend()))

	state.pipeline = sg.make_pipeline(
		{
			shader = shader,
			layout = {attrs = {0 = {format = .FLOAT3}}},
			label = "triangle-pipeline",
		},
	)

	state.pass_action.colors[0] = {
		load_action = .CLEAR,
		clear_value = {0.702, 0.922, 0.949, 1.00},
	}
}

frame :: proc "c" () {
	context = default_context

	sg.begin_pass({action = state.pass_action, swapchain = sglue.swapchain()})

	sg.apply_pipeline(state.pipeline)

	bindings: sg.Bindings
	bindings.vertex_buffers[0] = state.vertex_buffer
	sg.apply_bindings(bindings)

	// draw the triangle
	sg.draw(0, 3, 1)

	sg.end_pass()
	sg.commit()
}

cleanup :: proc "c" () {
	context = default_context
	sg.shutdown()
}
