package app

import "base:runtime"
import "core:mem"
import "core:mem/virtual"
import "topdown_game:internal/logger"
import "topdown_game:src/utils"

import "topdown_game:src/game"
import "topdown_game:src/input"
import "topdown_game:src/renderer"
import sapp "topdown_game:third_party/sokol/app"
import slog "topdown_game:third_party/sokol/log"

App :: struct {
	Game:         game.Game2D,
	Renderer:     renderer.Renderer,
	InputManager: input.InputManager,

	// memory management
	Context:      runtime.Context,
	Arena:        virtual.Arena,
}

// The global instance of app, which is used when app.run() is called
//
// NOTE: This instance is created as a global becuase sapp callbacks are proc "c" functions that don't take any arguments,
// hence a global state must be defined i.e. this app instance
APP: App

// Calls sapp.run with _init, _frame and _cleanup callbacks
//
// WARN: init() MUST be called before run() is called
run :: proc() {
	sapp.run(
		{
			init_cb = _init_cb,
			frame_cb = _frame_cb,
			event_cb = _input_cb,
			cleanup_cb = _cleanup_cb,
			width = utils.DEFAULT_WINDOW_WIDTH,
			height = utils.DEFAULT_WINDOW_HEIGHT,
			fullscreen = false,
			window_title = "2d-topdown-game",
			icon = {sokol_default = true},
			logger = {func = slog.func},
		},
	)
}

@(private)
_init_cb :: proc "c" () {
	// setup arena allocator. lifetime: until sapp runs, when sapp exits the arena gets destroyed in its cleanup callback
	context = runtime.default_context()
	alloc_err := virtual.arena_init_growing(&APP.Arena, 1 * mem.Megabyte)
	if alloc_err != nil {
		panic("Error creating virtual arena in app.init()")
	}
	context.allocator = virtual.arena_allocator(&APP.Arena)
	APP.Context = context

	game.Init(&APP.Game)
	renderer.Init(&APP.Renderer)
}

@(private)
_input_cb :: proc "c" (event: ^sapp.Event) {
	context = APP.Context

	#partial switch event.type {
	case .KEY_UP, .KEY_DOWN:
		input.RegisterKeyboardInput(&APP.InputManager, event)
	case .MOUSE_MOVE:
		input.RegisterMouseMove(&APP.InputManager, event)
	}
}

// TODO: pass delta time
@(private)
_frame_cb :: proc "c" () {
	context = APP.Context

	game.Update(&APP.Game, &APP.InputManager)
	renderer.Update(&APP.Renderer, &APP.Game)

	// per-frame cleanup
	input.Update(&APP.InputManager)
	free_all(context.temp_allocator)
}

@(private)
_cleanup_cb :: proc "c" () {
	context = APP.Context

	game.Cleanup(&APP.Game)
	renderer.Cleanup(&APP.Renderer)

	virtual.arena_destroy(&APP.Arena)
	free_all(context.temp_allocator)
}
