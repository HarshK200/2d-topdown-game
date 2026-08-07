package game

import "topdown_game:internal/game_math"

Camera2D :: struct {
	position: game_math.vec2,
	near:     f32,
	far:      f32,
	// todo add rotation
}

init_camera :: proc(game: ^Game2D) {
	game.camera.position = {0.0, 0.0}
	game.camera.near = -1
	game.camera.far = 1
}

/*
    A simple view matrix for 2d camera
    NOTE: 3D cameras use a lookat matrix to construct a view matrix as they have orientation as well, it
    is not required for a simple 2D camera though

    TODO: add camera rotation
    NOTE: keep in mind when adding rotation since view matrix is inverse of camera transformation
    we reverse the order of SRT i.e. it becomes TRS i.e. Translate * Rotate * Scale
*/
view_matrix_from_camera2d :: proc(camera: ^Camera2D) -> game_math.mat4 {
	view_mat := game_math.Translate_Mat4({-camera.position.x, -camera.position.y, 0.0})

	return view_mat
}
