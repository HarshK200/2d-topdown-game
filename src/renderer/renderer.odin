package renderer

import gmath "topdown_game:internal/game_math"
import "topdown_game:internal/logger"
import game "topdown_game:src/game"
import "topdown_game:src/utils"
import stbi "vendor:stb/image"

import shaders "topdown_game:src/shaders/build"
import sg "topdown_game:third_party/sokol/gfx"
import sglue "topdown_game:third_party/sokol/glue"
import slog "topdown_game:third_party/sokol/log"

Renderer :: struct {
	internal_resolution: [2]f32,
	default_pipeline:    sg.Pipeline,
	default_pass_action: sg.Pass_Action,

	// premitive 2d meshs
	triangle_mesh:       Mesh2D,
	quad_mesh:           Mesh2D,

	// textures
	textures:            [1]Texture2D,
}

init :: proc(renderer: ^Renderer) {
	logger.info("Initializing renderer...")
	renderer.internal_resolution = {640, 360}

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
					shaders.ATTR_default_albedo0 = {format = .FLOAT4},
				},
			},
			index_type = .UINT16,
			cull_mode = .NONE,
		},
	)


	// primitives setup
	renderer.triangle_mesh = _make_triangle_mesh()
	renderer.quad_mesh = _make_quad_mesh()


	// loading textures
	renderer.textures[utils.TextureID.PLAYER_SPRITE] = {
		id = decode_and_upload_tex(utils.load_image_file("./assets/textures/player_sprite.png")),
	}
}

update :: proc(renderer: ^Renderer, g: ^game.Game2D) {
	sg.begin_pass({action = renderer.default_pass_action, swapchain = sglue.swapchain()})
	sg.apply_pipeline(renderer.default_pipeline)

	// uniforms set per frame
	frame_params := shaders.Frame_Params {
		VIEW       = game.view_matrix_from_camera2d(&g.camera),
		PROJECTION = gmath.Orthographic_Mat4(
			0,
			renderer.internal_resolution.x,
			renderer.internal_resolution.y,
			0,
			g.camera.near,
			g.camera.far,
		),
	}
	sg.apply_uniforms(shaders.UB_frame_params, {ptr = &frame_params, size = size_of(frame_params)})


	// actual drawing
	draw_player(renderer, g)


	sg.end_pass()
	sg.commit()
}

cleanup :: proc(renderer: ^Renderer) {
	_destroy_mesh(&renderer.triangle_mesh)
	_destroy_mesh(&renderer.quad_mesh)

	sg.shutdown()
}

// decodes image using stbi and uploads it to the gpu, returns the GPU handler for uploaded texture
decode_and_upload_tex :: proc(img_data: []byte) -> sg.Image {
	width, height, channels_in_file: i32
	// 4 desired channels as GPU expects 4 channels
	pixel_data := stbi.load_from_memory(
		raw_data(img_data),
		i32(len(img_data)),
		&width,
		&height,
		&channels_in_file,
		4,
	)
	if pixel_data == nil {
		logger.error("Error decoding pixel data")
	}

	img_handle := sg.make_image(
	{
		width = width,
		height = height,
		pixel_format = .RGBA8,
		// NOTE: size is (w * h * 4) its multiplied by 4 because for each pixel there are 4 bytes of data i.e. RGBA
		data = {mip_levels = {0 = {ptr = pixel_data, size = uint(width * height * 4)}}},
	},
	)

	return img_handle
}
