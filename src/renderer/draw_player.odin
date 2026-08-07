package renderer

import gmath "topdown_game:internal/game_math"
import "topdown_game:src/game"
import shaders "topdown_game:src/shaders/build"
import sg "topdown_game:third_party/sokol/gfx"

draw_player :: proc(renderer: ^Renderer, g: ^game.Game2D) {
	model :=
		gmath.Translate_Mat4({g.player.position.x, g.player.position.y, 0.0}) *
		gmath.Scale_Mat4({g.player.scale.x, g.player.scale.y, 1.0})

	entity_params := shaders.Entity_Params {
		MODEL = model,
	}
	sg.apply_uniforms(
		shaders.UB_entity_params,
		{ptr = &entity_params, size = size_of(entity_params)},
	)

	_draw_mesh(&renderer.quad_mesh, 1)
}
