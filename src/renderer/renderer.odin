package renderer

import "core:log"

import shaders "topdown_game:src/shaders/gen"
import sg "topdown_game:third_party/sokol/gfx"
import sglue "topdown_game:third_party/sokol/glue"
import slog "topdown_game:third_party/sokol/log"

Renderer :: struct {
	bindings:    sg.Bindings,
	pipeline:    sg.Pipeline,
	pass_action: sg.Pass_Action,
}

init :: proc(renderer: ^Renderer) {
	log.info("Initializing renderer...")

	// setup device sokol sfx environment for platform specific graphics API like DirectX, OpenGL, etc
	sg.setup({environment = sglue.environment(), logger = {func = slog.func}})


	// pass action to clear framebuffer to black
	renderer.pass_action = {
		colors = {
			0 = {load_action = .CLEAR, clear_value = {r = 1.0, g = 0.41176, b = 0.38039, a = 1.0}},
		},
	}

	// compile shaders
	triangle_shader := sg.make_shader(shaders.triangle_shader_desc(sg.query_backend()))

	// make pipeline
	renderer.pipeline = sg.make_pipeline(
		{
			shader = triangle_shader,
			layout = {
				attrs = {
					shaders.ATTR_triangle_position = {format = .FLOAT3},
					shaders.ATTR_triangle_albedo = {format = .FLOAT4},
				},
			},
		},
	)

	// odinfmt: disable
	// triangle vertices
	vertices:= [?]f32 {
		// position			// color
		 0.0,  0.5, 0.0,	1.0, 0.0, 0.0, 1.0,
		 0.5, -0.5, 0.0,	0.0, 1.0, 0.0, 1.0,
		-0.5, -0.5, 0.0,	0.0, 0.0, 1.0, 1.0,
	}
	// odinfmt: enable

	// load triangle vertices into GPU VRAM
	renderer.bindings.vertex_buffers[0] = sg.make_buffer(
		{
			usage = {vertex_buffer = true, immutable = true},
			data = {ptr = &vertices, size = size_of(vertices)},
			label = "Triangle vertex buffer",
		},
	)

}

draw :: proc(renderer: ^Renderer) {
	sg.begin_pass({action = renderer.pass_action, swapchain = sglue.swapchain()})
	sg.apply_pipeline(renderer.pipeline)
	sg.apply_bindings(renderer.bindings)
	sg.draw(0, 3, 1)
	sg.end_pass()
	sg.commit()
}

cleanup :: proc(renderer: ^Renderer) {
	sg.shutdown()
}
