package renderer

import gmath "topdown_game:internal/game_math"
import shaders "topdown_game:src/shaders/build"
import sg "topdown_game:third_party/sokol/gfx"

draw_player :: proc(renderer: ^Renderer) {
	model := gmath.translate_mat4({0.0, 0.4, 0.0}) * gmath.scale_mat4({0.5, 0.5, 1.0})

	entity_params := shaders.Entity_Params {
		MODEL = model,
	}
	sg.apply_uniforms(
		shaders.UB_entity_params,
		{ptr = &entity_params, size = size_of(entity_params)},
	)

	_draw_mesh(&renderer.quad_mesh, 1)
}
