package game

import "core:math"
import gmath "topdown_game:internal/game_math"
import "topdown_game:src/input"
import "topdown_game:src/utils"

Game2D :: struct {
	player:        Player,
	camera:        Camera2D,

	// ================= TESTING =================
	temp_tile_pos: gmath.vec2,
	// ================= TESTING =================
}

Init :: proc(g: ^Game2D) {
	init_player(g)
	init_camera(g)
}

Update :: proc(g: ^Game2D, im: ^input.InputManager) {
	update_player(g, im)


	// =============== TESTING MOUSE SCREEN TO WORLD ===============
	// internal resultion is 640x360, render window default resolution is 1280x720
	mouse_ndc := utils.screen_to_ndc(im.mouse_pos, {f32(im.window_width), f32(im.window_height)})
	proj_mat := gmath.Orthographic_Mat4_RH_ZO(
		0,
		utils.INTERNAL_RENDER_RESOLUTION.x,
		utils.INTERNAL_RENDER_RESOLUTION.y,
		0,
		g.camera.near,
		g.camera.far,
	)
	inv_view_mat := inv_view_matrix_from_camera2d(&g.camera)
	mouse_world_pos :=
		inv_view_mat *
		gmath.InvOrthographic_Mat4(proj_mat) *
		gmath.vec4{mouse_ndc.x, mouse_ndc.y, 0.0, 1.0}

	// NOTE: adding tile_size/2 because quad_mesh center is 0.5 offseted
	g.temp_tile_pos = {
		math.floor((mouse_world_pos.x + (32 / 2)) / 32) * 32,
		math.floor((mouse_world_pos.y + (32 / 2)) / 32) * 32,
	}
	// =============== TESTING MOUSE SCREEN TO WORLD ===============
}


Cleanup :: proc(g: ^Game2D) {}
