package game

import "topdown_game:src/input"

Game2D :: struct {
	player: Player,
	camera: Camera2D,
	world:  World, // gets loaded in the game.Init()
}

Init :: proc(g: ^Game2D) {
	init_player(g)
	init_camera(g)

	load_world(&g.world)
}

Update :: proc(g: ^Game2D, im: ^input.InputManager, dt: f32) {
	update_player(g, im, dt)
	update_camera(g)
}


Cleanup :: proc(g: ^Game2D) {}
