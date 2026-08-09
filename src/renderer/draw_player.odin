package renderer

import gmath "topdown_game:internal/game_math"
import "topdown_game:src/game"
import shaders "topdown_game:src/shaders/build"
import "topdown_game:src/utils"
import sg "topdown_game:third_party/sokol/gfx"

draw_player :: proc(renderer: ^Renderer, g: ^game.Game2D) {
	model :=
		gmath.Translate_Mat4({g.player.position.x, g.player.position.y, 0.0}) *
		gmath.Scale_Mat4({g.player.scale.x, g.player.scale.y, 1.0})

	player_tex := renderer.textures[utils.TextureID.PLAYER_SPRITE]
	player_tex_coords := g.player.sprite.texel_coords

	// normalized 0..1 player uv min to be sampled from the texture
	uv_min := player_tex_coords
	uv_min.x /= f32(player_tex.width)
	uv_min.y /= f32(player_tex.height)

	// normalized 0..1 player uv max to be sampled from the texture
	uv_max := player_tex_coords + g.player.scale
	uv_max.x /= f32(player_tex.width)
	uv_max.y /= f32(player_tex.height)

	entity_params := shaders.Entity_Params {
		MODEL  = model,
		UV_MIN = uv_min,
		UV_MAX = uv_max,
	}
	sg.apply_uniforms(
		shaders.UB_entity_params,
		{ptr = &entity_params, size = size_of(entity_params)},
	)

	// set the player view i.e. texture in the bindings of quad_mesh before draw call
	renderer.quad_mesh.bindings.views[0] = renderer.textures[g.player.sprite.texture_id].sg_view

	_draw_mesh(&renderer.quad_mesh, 1)
}
