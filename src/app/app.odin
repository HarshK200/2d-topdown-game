package app

import "base:runtime"
import "core:log"

import "topdown_game:src/game"
import "topdown_game:src/renderer"
import sapp "topdown_game:third_party/sokol/app"
import slog "topdown_game:third_party/sokol/log"

App :: struct {
	Game:     game.Game2D,
	Renderer: renderer.Renderer,
}

// The global instance of app, which is used when app.run() is called
app: App

// Calls sapp.run with _init, _frame and _cleanup callbacks
run :: proc() {
	sapp.run(
		{
			init_cb = _init,
			frame_cb = _frame,
			cleanup_cb = _cleanup,
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
_init :: proc "c" () {
	context = runtime.default_context()
	context.logger = log.create_console_logger()

	game.init(&app.Game)
	renderer.init(&app.Renderer)
}

@(private)
_frame :: proc "c" () {
	context = runtime.default_context()
	context.logger = log.create_console_logger()

	renderer.draw(&app.Renderer)
}

@(private)
_cleanup :: proc "c" () {
	context = runtime.default_context()
	context.logger = log.create_console_logger()

	renderer.cleanup(&app.Renderer)
}
