package renderer

import "topdown_game:internal/logger"
import "topdown_game:src/game"

import gmath "topdown_game:internal/game_math"
import shaders "topdown_game:src/shaders/build"

append_draw_cmd_player :: proc(renderer: ^Renderer, g: ^game.Game2D) {
	model :=
		gmath.Translate_Mat4({g.player.position.x, g.player.position.y, 0.0}) *
		gmath.Scale_Mat4({g.player.scale.x, g.player.scale.y, 1.0})

	player_tex, ok := renderer.textures[g.player.sprite.texture_id]
	if !ok {
		logger.errorf(
			"Couldn't find player texture, invalid texture_id: %s",
			g.player.sprite.texture_id,
		)
	}

	player_tex_coords := g.player.sprite.texel_coords

	// normalized 0..1 player uv min to be sampled from the texture
	uv_min := player_tex_coords
	uv_min.x /= f32(player_tex.width)
	uv_min.y /= f32(player_tex.height)

	// normalized 0..1 player uv max to be sampled from the texture
	uv_max := player_tex_coords + (g.player.scale - 1) // NOTE: offset by 1 px because of 0 indexed
	uv_max.x /= f32(player_tex.width)
	uv_max.y /= f32(player_tex.height)

	entity_params := shaders.Entity_Params {
		MODEL  = model,
		UV_MIN = uv_min,
		UV_MAX = uv_max,
	}

	draw_cmd: DrawCommand = {
		pos          = g.player.position,
		texture_id   = player_tex.texture_id,
		entityParams = entity_params,
	}

	append(&renderer.draw_queue, draw_cmd)
}
