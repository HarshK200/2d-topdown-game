package renderer

import "topdown_game:internal/logger"
import "topdown_game:src/game"
import "topdown_game:src/renderer/mesh"
import "topdown_game:src/utils"

import gmath "topdown_game:internal/game_math"
import shaders "topdown_game:src/shaders/build"
import sg "topdown_game:third_party/sokol/gfx"
import sglue "topdown_game:third_party/sokol/glue"
import slog "topdown_game:third_party/sokol/log"


Renderer :: struct {
	default_pipeline:    sg.Pipeline,
	default_pass_action: sg.Pass_Action,
	textures:            map[string]Texture2D,
	draw_queue:          [dynamic]DrawCommand,

	// premitive 2d meshs
	triangle_mesh:       mesh.Mesh2D,
	quad_mesh:           mesh.Mesh2D,
}

Init :: proc(renderer: ^Renderer) {
	logger.info("Initializing renderer...")

	// setup device sokol sfx environment for platform specific graphics API like DirectX, OpenGL, etc
	sg.setup({environment = sglue.environment(), logger = {func = slog.func}})
	logger.infof("Backend: %v", sg.query_backend())

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
					shaders.ATTR_default_texcoord0 = {format = .FLOAT2},
				},
			},
			index_type = .UINT16,
			cull_mode = .NONE,
		},
	)


	// primitives setup
	renderer.triangle_mesh = mesh.make_triangle_mesh()
	renderer.quad_mesh = mesh.make_quad_mesh()


	// loading textures
	load_all_textures(renderer)
}

Update :: proc(renderer: ^Renderer, g: ^game.Game2D) {
	sg.begin_pass({action = renderer.default_pass_action, swapchain = sglue.swapchain()})
	sg.apply_pipeline(renderer.default_pipeline)

	// uniforms set per frame
	frame_params := shaders.Frame_Params {
		VIEW       = game.view_matrix_from_camera2d(&g.camera),
		// FOLLOWS Y+ "Down" CONVENTION
		PROJECTION = gmath.Orthographic_Mat4_RH_ZO(
			0,
			utils.INTERNAL_RENDER_RESOLUTION.x,
			utils.INTERNAL_RENDER_RESOLUTION.y,
			0,
			g.camera.near,
			g.camera.far,
		),
	}
	sg.apply_uniforms(shaders.UB_frame_params, {ptr = &frame_params, size = size_of(frame_params)})


	// ====================== Drawing Layer 1 ======================
	append_draw_cmd_tilemap(renderer, g)
	DrawLayer(renderer, true)
	clear(&renderer.draw_queue)

	// ====================== Drawing Layer 2 ======================
	append_draw_cmd_player(renderer, g)
	DrawLayer(renderer, true)
	clear(&renderer.draw_queue)


	sg.end_pass()
	sg.commit()
}

Cleanup :: proc(renderer: ^Renderer) {
	mesh.destroy_mesh(&renderer.triangle_mesh)
	mesh.destroy_mesh(&renderer.quad_mesh)

	sg.shutdown()
}
