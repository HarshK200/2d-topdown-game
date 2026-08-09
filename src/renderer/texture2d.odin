package renderer

import sg "topdown_game:third_party/sokol/gfx"

Texture2D :: struct {
	sg_img:   sg.Image,
	sg_view:  sg.View,
	width:    i32,
	height:   i32,
	channels: i32,
}
