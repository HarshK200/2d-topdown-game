package input

import "topdown_game:internal/logger"
import gmath "topdown_game:internal/game_math"
import sapp "topdown_game:third_party/sokol/app"

Actions :: enum {
	MOVE_UP,
	MOVE_DOWN,
	MOVE_LEFT,
	MOVE_RIGHT,
	ZOOM_IN,
	ZOOM_OUT,
}
ActionState :: enum {
	IDLE,
	PRESSED,
	HELD,
	RELEASED,
}

InputManager :: struct {
	action_map:    [Actions]ActionState, // defaults to the first ActionState value i.e. IDLE
	mouse_pos:     gmath.vec2,
	window_width:  i32,
	window_height: i32,
}


// ============================= REGISTER INPUT HANDLERS =============================


/*
    Processes a Sokol input event type = KEY_DOWN/KEY_UP event and updates the corresponding action state.

    NOTE: Input events must be processed before InputManager.Update(),
    which transitions transient action states at the end of the frame.
*/
RegisterKeyboardInput :: proc(im: ^InputManager, event: ^sapp.Event) {
	assert(event.type == .KEY_UP || event.type == .KEY_DOWN)
	#partial switch event.key_code {
	case .W:
		register_action_map(im, event, .MOVE_UP)

	case .S:
		register_action_map(im, event, .MOVE_DOWN)

	case .A:
		register_action_map(im, event, .MOVE_LEFT)

	case .D:
		register_action_map(im, event, .MOVE_RIGHT)
	}
}

/*
    Processes a Sokol input event type = MOUSE_MOVE and updates the corresponding action state.

    NOTE: Input events must be processed before InputManager.Update(),
    which transitions transient action states at the end of the frame.
*/
RegisterMouseMove :: proc(im: ^InputManager, event: ^sapp.Event) {
	assert(event.type == .MOUSE_MOVE)

	// NOTE: the event.mouse_x and event.mouse_y are in pixel-coords e.g. 1280x720
	im.mouse_pos.x = event.mouse_x
	im.mouse_pos.y = event.mouse_y

	im.window_width = event.window_width
	im.window_height = event.window_height
}

/*
    Processes a Sokol input event type = MOUSE_SCROLL and updates the corresponding action state.
    Scroll Y is the only usable value, x is probably for mouse ball?
    scroll_y is Y + "Up"

    NOTE: Input events must be processed before InputManager.Update(),
    which transitions transient action states at the end of the frame.
*/
RegisterMouseScroll :: proc(im: ^InputManager, event: ^sapp.Event) {
	assert(event.type == .MOUSE_SCROLL)

	// for +y i.e. scroll up
	if (event.scroll_y > 0) {
		im.action_map[.ZOOM_IN] = .PRESSED
	}

	// for -y i.e. scroll down
	if (event.scroll_y < 0) {
		im.action_map[.ZOOM_OUT] = .PRESSED
	}
}

// ===================================================================================


// Advances all action states for the next frame.
//
// NOTE: Call once at the end of each frame.
Update :: proc(im: ^InputManager) {

	for action in Actions {
		// Always transition to IDLE for some actions
		if (action == .ZOOM_IN || action == .ZOOM_OUT) {
			im.action_map[action] = .IDLE
			continue
		}

		#partial switch im.action_map[action] {
		case .PRESSED:
			im.action_map[action] = .HELD
		case .RELEASED:
			im.action_map[action] = .IDLE
		}
	}
}

// Resets all the input_manager actions to IDLE
ClearAll :: proc(im: ^InputManager) {
	for action in Actions {
		im.action_map[action] = .IDLE
	}
}

// ====================== Helpers for Game =======================

// returns if an action was just pressed
IsActionPressed :: proc(im: ^InputManager, action: Actions) -> bool {
	return im.action_map[action] == .PRESSED
}
IsActionHeld :: proc(im: ^InputManager, action: Actions) -> bool {
	return im.action_map[action] == .HELD
}
IsActionReleased :: proc(im: ^InputManager, action: Actions) -> bool {
	return im.action_map[action] == .RELEASED
}

// ==================== Priavte Helper functions ====================
@(private)
register_action_map :: proc(im: ^InputManager, event: ^sapp.Event, action: Actions) {
	#partial switch event.type {
	case .KEY_DOWN:
		im.action_map[action] = .PRESSED
	case .KEY_UP:
		im.action_map[action] = .RELEASED
	}
}
