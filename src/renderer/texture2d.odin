package renderer

import "topdown_game:internal/logger"
import "topdown_game:src/utils"

import sg "topdown_game:third_party/sokol/gfx"
import stbi "vendor:stb/image"

Texture2D :: struct {
	texture_id: string,
	sg_img:     sg.Image,
	sg_view:    sg.View,
	width:      i32,
	height:     i32,
	channels:   i32,
}

@(private)
load_all_textures :: proc(renderer: ^Renderer) {
	// texture file paths
	texture_paths: map[string]string
	texture_paths["layer0_spritesheet"] = "./assets/textures/layer0_spritesheet.png"
	texture_paths["layer1_spritesheet"] = "./assets/textures/layer1_spritesheet.png"

	// reserve space for 2 textures as i'm uploading them
	reserve(&renderer.textures, 2)
	// loading textures and saving there GPU handles
	for tex_id, tex_path in texture_paths {
		img_data := utils.load_image_file(tex_path)
		map_insert(&renderer.textures, tex_id, decode_and_upload_tex(tex_id, img_data))
	}
}

@(private)
// decodes image using stbi and uploads it to the gpu, returns Texture2D
decode_and_upload_tex :: proc(texture_id: string, img_data: []byte) -> Texture2D {
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

	// NOTE: size is (w * h * 4) because for each pixel there are 4 bytes of data i.e. RGBA
	img_handle := sg.make_image(
		{
			width = width,
			height = height,
			pixel_format = .RGBA8,
			data = {mip_levels = {0 = {ptr = pixel_data, size = uint(width * height * 4)}}},
		},
	)

	// cleanup stbi created pixel_data
	stbi.image_free(pixel_data)

	view_handle := sg.make_view({texture = {image = img_handle}})

	return {
        texture_id = texture_id,
		sg_img = img_handle,
		sg_view = view_handle,
		width = width,
		height = height,
		channels = channels_in_file,
	}
}
