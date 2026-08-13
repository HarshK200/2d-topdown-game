package input

import sapp "topdown_game:third_party/sokol/app"

Actions :: enum {
	MOVE_UP,
	MOVE_DOWN,
	MOVE_LEFT,
	MOVE_RIGHT,
}
ActionState :: enum {
	IDLE,
	PRESSED,
	HELD,
	RELEASED,
}

InputManager :: struct {
	action_map: [Actions]ActionState, // defaults to the first ActionState value i.e. IDLE
}

// Processes a Sokol input event and updates the corresponding action state.
//
// NOTE: Input events must be processed before InputManager.Update(),
// which transitions transient action states at the end of the frame.
RegisterInput :: proc(im: ^InputManager, event: ^sapp.Event) {
	switch {
	case event.key_code == .W:
		register_action_map(im, event, .MOVE_UP)

	case event.key_code == .S:
		register_action_map(im, event, .MOVE_DOWN)

	case event.key_code == .A:
		register_action_map(im, event, .MOVE_LEFT)

	case event.key_code == .D:
		register_action_map(im, event, .MOVE_RIGHT)
	}
}

// Advances all action states for the next frame.
//
// NOTE: Call once at the end of each frame.
Update :: proc(im: ^InputManager) {
	for action in Actions {
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
