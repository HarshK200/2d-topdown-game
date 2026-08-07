package game

import math "topdown_game:internal/game_math"

Player :: struct {
	position: math.vec2,
	scale:    math.vec2,
	// TODO
	// rotation:
}

init_player :: proc(game: ^Game2D) {
	game.player.position = {100.0, 100.0}
	game.player.scale = {32, 48}
}
