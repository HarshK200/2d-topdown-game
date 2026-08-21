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

init_player :: proc(g: ^Game2D) {
	g.player.position = {0.0, 0.0}
	g.player.scale = {32, 48}
	g.player.speed = 120.0

	g.player.sprite = {
		texture_id   = "entity_texture_atlas",
		texel_coords = {0, 0},
	}
}

update_player :: proc(g: ^Game2D, im: ^input.InputManager, dt: f32) {
	input_dir := calculate_input_dir(im)
	new_pos := g.player.position + (input_dir * g.player.speed * dt)

	g.player.position = new_pos
}


@(private)
calculate_input_dir :: proc(im: ^input.InputManager) -> gmath.vec2 {
	input_dir: gmath.vec2 = {0, 0}

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
