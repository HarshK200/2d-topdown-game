package game

Game2D :: struct {
	player: Player,
	camera: Camera2D,
}

init :: proc(game: ^Game2D) {
	init_player(game)
	init_camera(game)
}

update :: proc(game: ^Game2D) {
}

cleanup :: proc(game: ^Game2D) {}
