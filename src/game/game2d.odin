package game

import "topdown_game:src/input"

Game2D :: struct {
	player: Player,
	camera: Camera2D,
}

Init :: proc(game: ^Game2D) {
	init_player(game)
	init_camera(game)
}

Update :: proc(game: ^Game2D, im: ^input.InputManager) {
	update_player(game, im)
}


Cleanup :: proc(game: ^Game2D) {}
