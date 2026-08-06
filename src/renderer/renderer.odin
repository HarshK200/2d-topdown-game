package renderer

import gmath "topdown_game:internal/game_math"
import "topdown_game:internal/logger"
import game "topdown_game:src/game"

import shaders "topdown_game:src/shaders/build"
import sg "topdown_game:third_party/sokol/gfx"
import sglue "topdown_game:third_party/sokol/glue"
import slog "topdown_game:third_party/sokol/log"

Renderer :: struct {
	default_pipeline:    sg.Pipeline,
	default_pass_action: sg.Pass_Action,

	// premitive 2d meshs
	triangle_mesh:       Mesh2D,
	quad_mesh:           Mesh2D,
}

init :: proc(renderer: ^Renderer) {
	logger.info("Initializing renderer...")

	// setup device sokol sfx environment for platform specific graphics API like DirectX, OpenGL, etc
	sg.setup({environment = sglue.environment(), logger = {func = slog.func}})
	// pass action to clear framebuffer to black
	renderer.default_pass_action = {
		colors = {0 = {load_action = .CLEAR, clear_value = {r = 0.0, g = 0.0, b = 0.0, a = 1.0}}},
	}

	// compile shaders
	default_shader := sg.make_shader(shaders.default_shader_desc(sg.query_backend()))

	// make pipeline (for index buffer)
	renderer.default_pipeline = sg.make_pipeline(
		{
			shader = default_shader,
			layout = {
				attrs = {
					shaders.ATTR_default_position = {format = .FLOAT3},
					shaders.ATTR_default_albedo0 = {format = .FLOAT4},
				},
			},
			index_type = .UINT16,
			cull_mode = .BACK,
		},
	)


	// primitives setup
	renderer.triangle_mesh = _make_triangle_mesh()
	renderer.quad_mesh = _make_quad_mesh()
}

update :: proc(renderer: ^Renderer, g: ^game.Game2D) {
	sg.begin_pass({action = renderer.default_pass_action, swapchain = sglue.swapchain()})
	sg.apply_pipeline(renderer.default_pipeline)


	// uniforms set per frame
	// TODO: make these view and projection matrix. NOTE: view matrix comes from camera.lookat and camera2D
	frame_params := shaders.Frame_Params {
		VIEW       = game.view_matrix_from_camera2d(&g.camera),
		PROJECTION = gmath.identity_mat4(),
	}
	sg.apply_uniforms(shaders.UB_frame_params, {ptr = &frame_params, size = size_of(frame_params)})


	draw_player(renderer)

	sg.end_pass()
	sg.commit()
}

cleanup :: proc(renderer: ^Renderer) {
	_destroy_mesh(&renderer.triangle_mesh)
	_destroy_mesh(&renderer.quad_mesh)

	sg.shutdown()
}
