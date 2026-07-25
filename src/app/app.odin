package app

import "base:runtime"
import "core:log"
import "topdown_game:internal/logger"

import "topdown_game:src/game"
import "topdown_game:src/renderer"
import sapp "topdown_game:third_party/sokol/app"
import slog "topdown_game:third_party/sokol/log"

App :: struct {
	Game:     game.Game2D,
	Renderer: renderer.Renderer,
	Context:  runtime.Context,
}

// The global instance of app, which is used when app.run() is called
//
// NOTE: This instance is created as a global becuase sapp callbacks are proc "c" functions that don't take any arguments,
// hence a global state must be defined i.e. this app instance
APP: App

// This procedure initializes the global APP variable
//
// NOTE: this function MUST be called before calling run
init :: proc() {
	APP.Context = runtime.default_context()
}

// Calls sapp.run with _init, _frame and _cleanup callbacks
//
// WARN: init() MUST be called before run() is called
run :: proc() {
	context = APP.Context

	sapp.run(
		{
			init_cb = _init_cb,
			frame_cb = _frame_cb,
			cleanup_cb = _cleanup_cb,
			width = 800,
			height = 600,
			fullscreen = false,
			window_title = "2d-topdown-game",
			icon = {sokol_default = true},
			logger = {func = slog.func},
		},
	)
}

@(private)
_init_cb :: proc "c" () {
	context = APP.Context

	game.init(&APP.Game)
	renderer.init(&APP.Renderer)
}

@(private)
_frame_cb :: proc "c" () {
	context = APP.Context

	game.update(&APP.Game)
	renderer.update(&APP.Renderer, &APP.Game)
}

@(private)
_cleanup_cb :: proc "c" () {
	context = APP.Context

	game.cleanup(&APP.Game)
	renderer.cleanup(&APP.Renderer)
}
