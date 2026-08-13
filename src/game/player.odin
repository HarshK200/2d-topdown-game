package game

import gmath "topdown_game:internal/game_math"
import "topdown_game:src/input"

Player :: struct {
	position: gmath.vec2,
	scale:    gmath.vec2, // 1 unit = 1 pixel
	speed:    f32,
	sprite:   Sprite2D,

	// TODO: rotation
}

init_player :: proc(game: ^Game2D) {
	game.player.position = {100.0, 100.0}
	game.player.scale = {32, 48}
	game.player.speed = 0.5

	game.player.sprite = {
		texture_id   = .PLAYER_SPRITE,
		texel_coords = {0, 0},
	}
}

update_player :: proc(game: ^Game2D, im: ^input.InputManager) {
	input_dir := calculate_input_dir(im)

	new_pos := game.player.position.xy + (input_dir.xy * game.player.speed)

	game.player.position = new_pos
}


@(private)
calculate_input_dir :: proc(im: ^input.InputManager) -> gmath.vec2 {
	input_dir: gmath.vec2 = {0, 0}

	// TODO: make this frame rate independent
	if input.IsActionPressed(im, .MOVE_UP) || input.IsActionHeld(im, .MOVE_UP) {
		input_dir.y = -1
	}
	if input.IsActionPressed(im, .MOVE_DOWN) || input.IsActionHeld(im, .MOVE_DOWN) {
		input_dir.y = +1
	}
	if input.IsActionPressed(im, .MOVE_LEFT) || input.IsActionHeld(im, .MOVE_LEFT) {
		input_dir.x = -1
	}
	if input.IsActionPressed(im, .MOVE_RIGHT) || input.IsActionHeld(im, .MOVE_RIGHT) {
		input_dir.x = +1
	}

	return gmath.Normalize(input_dir)
}
