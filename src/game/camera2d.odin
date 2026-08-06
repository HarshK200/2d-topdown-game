package game

import "topdown_game:internal/game_math"

Camera2D :: struct {
	position: game_math.vec2,
}

init_camera :: proc(game: ^Game2D) {
	game.camera.position = {0.0, 1.2}
}

view_matrix_from_camera2d :: proc(camera: ^Camera2D) -> game_math.mat4 {
	view_mat := game_math.translate_mat4({-camera.position.x, -camera.position.y, 0.0})

	return view_mat
}
