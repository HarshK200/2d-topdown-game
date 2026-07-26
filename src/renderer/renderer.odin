package renderer

import "topdown_game:internal/logger"
import "topdown_game:src/game"

import shaders "topdown_game:src/shaders/gen"
import sg "topdown_game:third_party/sokol/gfx"
import sglue "topdown_game:third_party/sokol/glue"
import slog "topdown_game:third_party/sokol/log"

Renderer :: struct {
	pipeline:      sg.Pipeline,
	pass_action:   sg.Pass_Action,
	triangle_mesh: Mesh2D,
	quad_mesh:     Mesh2D,
}

init :: proc(renderer: ^Renderer) {
	logger.info("Initializing renderer...")

	// setup device sokol sfx environment for platform specific graphics API like DirectX, OpenGL, etc
	sg.setup({environment = sglue.environment(), logger = {func = slog.func}})
	// pass action to clear framebuffer to black
	renderer.pass_action = {
		colors = {0 = {load_action = .CLEAR, clear_value = {r = 0.0, g = 0.0, b = 0.0, a = 1.0}}},
	}
	// compile shaders
	main_shader := sg.make_shader(shaders.main_shader_desc(sg.query_backend()))
	// make pipeline (for index buffer)
	renderer.pipeline = sg.make_pipeline(
		{
			shader = main_shader,
			index_type = .UINT16,
			layout = {
				attrs = {
					shaders.ATTR_main_position = {format = .FLOAT3},
					shaders.ATTR_main_albedo0 = {format = .FLOAT4},
				},
			},
		},
	)


	// primitives setup
	renderer.triangle_mesh = _make_triangle_mesh()
	renderer.quad_mesh = _make_quad_mesh()
}

update :: proc(renderer: ^Renderer, game: ^game.Game2D) {
	sg.begin_pass({action = renderer.pass_action, swapchain = sglue.swapchain()})
	sg.apply_pipeline(renderer.pipeline)

	_draw_mesh(&renderer.quad_mesh, 1)
	_draw_mesh(&renderer.triangle_mesh, 1)

	sg.end_pass()
	sg.commit()
}

cleanup :: proc(renderer: ^Renderer) {
	_destroy_mesh(&renderer.triangle_mesh)
	_destroy_mesh(&renderer.quad_mesh)

	sg.shutdown()
}
