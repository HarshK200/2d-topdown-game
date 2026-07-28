package game

Game2D :: struct {
	player: Player,
}

init :: proc(game: ^Game2D) {
	init_player(game)
}

update :: proc(game: ^Game2D) {
	update_player(game)
}

cleanup :: proc(game: ^Game2D) {}
