package renderer

import gmath "topdown_game:internal/game_math"
import "topdown_game:src/game"
import "topdown_game:src/renderer/mesh"
import shaders "topdown_game:src/shaders/build"
import "topdown_game:src/utils"
import sg "topdown_game:third_party/sokol/gfx"

draw_grass_tile :: proc(renderer: ^Renderer, g: ^game.Game2D) {
	model :=
		gmath.Translate_Mat4({g.temp_tile_pos.x, g.temp_tile_pos.y, 0.0}) *
		gmath.Scale_Mat4({32, 32, 1.0})

	tile_tex := renderer.textures[utils.TextureID.GRASS_TILE]
	tile_tex_coords := [2]f32{0.0, 0.0}

	// normalized 0..1 player uv min to be sampled from the texture
	uv_min := tile_tex_coords
	uv_min.x /= f32(tile_tex.width)
	uv_min.y /= f32(tile_tex.height)

	// normalized 0..1 player uv max to be sampled from the texture
	uv_max := tile_tex_coords + {16, 16}
	uv_max.x /= f32(tile_tex.width)
	uv_max.y /= f32(tile_tex.height)

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
	renderer.quad_mesh.bindings.views[0] = renderer.textures[utils.TextureID.GRASS_TILE].sg_view

	mesh.draw_mesh(&renderer.quad_mesh, 1)
}
