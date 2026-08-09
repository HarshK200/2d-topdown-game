package game

import math "topdown_game:internal/game_math"

Player :: struct {
	position: math.vec2,
	scale:    math.vec2, // 1 unit = 1 pixel
	sprite:   Sprite2D,

	// TODO: rotation
}

init_player :: proc(game: ^Game2D) {
	game.player.position = {100.0, 100.0}
	game.player.scale = {32, 48}

	game.player.sprite = {
		texture_id   = .PLAYER_SPRITE,
		texel_coords = {0, 0},
	}
}
