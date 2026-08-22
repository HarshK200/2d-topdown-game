package game

import "core:math"
import gmath "topdown_game:internal/game_math"
import "topdown_game:src/input"
import "topdown_game:src/utils"

Camera2D :: struct {
	position: gmath.vec2,
	zoom:     f32,
	near:     f32,
	far:      f32,

	// TODO: add rotation
	// TODO: add an offset: vec2 so when the view matrix is created the camera is offset by said value, so the camera's center is at center of the screen not top-left
}

init_camera :: proc(g: ^Game2D) {
	g.camera.position = {0.0, 0.0}
	g.camera.zoom = 1
	g.camera.near = -1
	g.camera.far = 1
}

update_camera :: proc(g: ^Game2D, im: ^input.InputManager, dt: f32) {
	g.camera.position = g.player.position

	// camera zoom
	if (utils.ENABLE_CAMERA_ZOOM) {
		if (input.IsActionPressed(im, .ZOOM_IN)) {
			g.camera.zoom += 0.025
		}
		if (input.IsActionPressed(im, .ZOOM_OUT)) {
			g.camera.zoom = math.max(g.camera.zoom - 0.025, 0.0001)
		}
	}
}

/*
    A simple view matrix for 2d camera
    NOTE: 3D cameras use a lookat matrix to construct a view matrix as they have orientation as well, it
    is not required for a simple 2D camera though

    TODO: add camera rotation
    NOTE: keep in mind when adding rotation since view matrix is inverse of camera transformation
    we reverse the order of SRT i.e. it becomes TRS i.e. Translate * Rotate * Scale
*/
view_matrix_from_camera2d :: proc(camera: ^Camera2D) -> gmath.mat4 {
	CAMERA_OFFSET_CENTER :: gmath.vec2 {
		(-utils.INTERNAL_RENDER_RESOLUTION.x / 2),
		(-utils.INTERNAL_RENDER_RESOLUTION.y / 2),
	} // centering the camera on player i.e. at (0, 0) i.e. topleft

	view_mat :=
		gmath.Translate_Mat4({-CAMERA_OFFSET_CENTER.x, -CAMERA_OFFSET_CENTER.y, 0.0}) *
		gmath.Scale_Mat4({camera.zoom, camera.zoom, 1.0}) *
		gmath.Translate_Mat4({-camera.position.x, -camera.position.y, 0.0})

	return view_mat
}

inv_view_matrix_from_camera2d :: proc(camera: ^Camera2D) -> gmath.mat4 {
	view_mat := gmath.Translate_Mat4({camera.position.x, camera.position.y, 0.0})

	return view_mat
}
