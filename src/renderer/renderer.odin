package renderer

import "topdown_game:internal/logger"
import "topdown_game:src/game"
import "topdown_game:src/renderer/mesh"
import "topdown_game:src/utils"

import gmath "topdown_game:internal/game_math"
import shaders "topdown_game:src/shaders/build"
import sdtx "topdown_game:third_party/sokol/debugtext"
import sg "topdown_game:third_party/sokol/gfx"
import sglue "topdown_game:third_party/sokol/glue"
import slog "topdown_game:third_party/sokol/log"


Renderer :: struct {
	default_pass_action: sg.Pass_Action,
	textures:            map[string]Texture2D,

	// shader pipelines
	tilemap_pipeline:    sg.Pipeline,
	default_pipeline:    sg.Pipeline,

	// premitive 2d meshs
	triangle_mesh:       mesh.Mesh2D,
	quad_mesh:           mesh.Mesh2D,
}

Init :: proc(renderer: ^Renderer, g: ^game.Game2D) {
	// ====================== Setup Sokol gfx and debug text ======================
	sg.setup({environment = sglue.environment(), logger = {func = slog.func}})
	sdtx.setup({fonts = {0 = sdtx.font_kc853()}, logger = {func = slog.func}})

	graphics_backend := sg.query_backend()
	logger.infof("Graphics Backend: %v", graphics_backend)


	// ====================== Pass Actions ======================
	renderer.default_pass_action = {
		colors = {0 = {load_action = .CLEAR, clear_value = {r = 0.0, g = 0.0, b = 0.0, a = 1.0}}},
	}


	// ====================== Make Shaders ======================
	tilemap_shader := sg.make_shader(shaders.tilemap_shader_desc(graphics_backend))
	default_shader := sg.make_shader(shaders.default_shader_desc(graphics_backend))


	// ====================== Make Pipelines ======================
	renderer.tilemap_pipeline = sg.make_pipeline(
		{
			shader = tilemap_shader,
			layout = {
				buffers = {0 = {step_func = .PER_VERTEX}, 1 = {step_func = .PER_INSTANCE}},
				attrs = {
					shaders.ATTR_tilemap_quad_pos = {buffer_index = 0, format = .FLOAT3},
					shaders.ATTR_tilemap_quad_texcoords = {buffer_index = 0, format = .FLOAT2},
					shaders.ATTR_tilemap_tile_pos = {buffer_index = 1, format = .FLOAT2},
					shaders.ATTR_tilemap_tile_scale = {buffer_index = 1, format = .FLOAT2},
					shaders.ATTR_tilemap_uv_min = {buffer_index = 1, format = .FLOAT2},
					shaders.ATTR_tilemap_uv_max = {buffer_index = 1, format = .FLOAT2},
				},
			},
			index_type = .UINT16,
			cull_mode = .NONE,
		},
	)
	renderer.default_pipeline = sg.make_pipeline(
		{
			shader = default_shader,
			layout = {
				attrs = {
					shaders.ATTR_default_quad_pos = {format = .FLOAT3},
					shaders.ATTR_default_quad_texcoords = {format = .FLOAT2},
				},
			},
			index_type = .UINT16,
			cull_mode = .NONE,
		},
	)


	// ====================== Upload premitive mesh vertex data ======================
	renderer.triangle_mesh = mesh.make_triangle_mesh()
	renderer.quad_mesh = mesh.make_quad_mesh()

	// ====================== Upload and store handle instance vertex buffers ======================
	renderer.quad_mesh.bindings.vertex_buffers[1] = make_tilemap_instance_buffer(renderer)

	// ====================== Load textures ======================
	load_all_textures(renderer)
}

Update :: proc(renderer: ^Renderer, g: ^game.Game2D, current_fps: u32) {
	sg.begin_pass({action = renderer.default_pass_action, swapchain = sglue.swapchain()})


	// ================ Per frame uniforms calculations [pipeline independent] ================
	VIEW := game.view_matrix_from_camera2d(&g.camera)
	// FOLLOWS Y+ "Down" CONVENTION
	PROJECTION := gmath.Orthographic_Mat4_RH_ZO(
		0,
		utils.INTERNAL_RENDER_RESOLUTION.x,
		utils.INTERNAL_RENDER_RESOLUTION.y,
		0,
		g.camera.near,
		g.camera.far,
	)


	// ====================== Tilemap Shader Pipeline ========================
	sg.apply_pipeline(renderer.tilemap_pipeline)
	tilemap_frame_params := shaders.Default_Frame_Params {
		VIEW       = VIEW,
		PROJECTION = PROJECTION,
	}
	sg.apply_uniforms(
		shaders.UB_tilemap_frame_params,
		{ptr = &tilemap_frame_params, size = size_of(tilemap_frame_params)},
	)
	// Draw tilemap layer
	DrawTilemapLayer(renderer, g)


	// ====================== Default Shader Pipeline ========================
	sg.apply_pipeline(renderer.default_pipeline)
	default_frame_params := shaders.Default_Frame_Params {
		VIEW       = VIEW,
		PROJECTION = PROJECTION,
	}
	sg.apply_uniforms(
		shaders.UB_default_frame_params,
		{ptr = &default_frame_params, size = size_of(default_frame_params)},
	)

	// Draw entity layer
	DrawEntityLayer(renderer, g)


	// ====================== Debug Overlay ========================
	sdtx.canvas(f32(utils.DEFAULT_WINDOW_WIDTH) * 0.5, f32(utils.DEFAULT_WINDOW_HEIGHT) * 0.5)
	sdtx.origin(1, 1)
	sdtx.color3b(246, 114, 128)
	// debug info draws
	sdtx.printf("fps: %d", current_fps)
	sdtx.draw()


	sg.end_pass()
	sg.commit()
}

Cleanup :: proc(renderer: ^Renderer) {
	mesh.destroy_mesh(&renderer.triangle_mesh)
	mesh.destroy_mesh(&renderer.quad_mesh)

	sdtx.shutdown()
	sg.shutdown()
}
