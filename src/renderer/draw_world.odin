package renderer

import gmath "topdown_game:internal/game_math"
import "topdown_game:internal/logger"
import "topdown_game:src/game"
import "topdown_game:src/renderer/mesh"
import shaders "topdown_game:src/shaders/build"
import sg "topdown_game:third_party/sokol/gfx"

draw_world :: proc(renderer: ^Renderer, g: ^game.Game2D) {

	// ============================== CHUNK RENDERING ==============================

	// player chunk coordinates
	player_chunk_coords := game.world_to_chunk_coords(g.player.position)

	// get the chunks around the player with 1 chunk radius and only render those
	chunks_coords_around_player: [dynamic]gmath.vec2i // draw chunks, 8 chunks around the player + 1 chunk below player
	neighbour_chunk: [9]gmath.vec2i = {
		{0, 0},
		{0, -1},
		{-1, -1},
		{-1, 0},
		{1, 0},
		{1, -1},
		{0, 1},
		{1, 1},
		{-1, 1},
	}
	for n, i in neighbour_chunk {
		chunk_coords := player_chunk_coords + n
		if chunk_coords not_in g.world.chunks {
			continue
		}
		append(&chunks_coords_around_player, chunk_coords)
	}
	for coords in chunks_coords_around_player {
		chunk := &g.world.chunks[coords]
		assert(coords in g.world.chunks) // coords must exist in the world chunk array due to previous check

		for &tile_row, idx_y in chunk.tiles {
			for &tile, idx_x in tile_row {
				draw_tile(renderer, &tile, {i32(idx_x), i32(idx_y)}, coords)
			}
		}
	}
}

draw_tile :: proc(
	renderer: ^Renderer,
	tile: ^game.Tile,
	tile_idx: gmath.vec2i,
	chunk_coords: gmath.vec2i,
) {
	tile_world_pos := game.tile_world_coords(tile_idx, chunk_coords)

	model :=
		gmath.Translate_Mat4({tile_world_pos.x, tile_world_pos.y, 0.0}) *
		gmath.Scale_Mat4({tile.scale.x, tile.scale.y, 1.0})

	tile_tex, ok := renderer.textures[tile.sprite2d.texture_id]
	if !ok {
		logger.errorf(
			"Couldn't find tile texture, invalid texture_id: %s",
			tile.sprite2d.texture_id,
		)
	}
	tile_texel_coords := tile.sprite2d.texel_coords

	// normalized 0..1 player uv min to be sampled from the texture
	uv_min := tile_texel_coords
	uv_min.x /= f32(tile_tex.width)
	uv_min.y /= f32(tile_tex.height)

	// normalized 0..1 player uv max to be sampled from the texture
	uv_max := tile_texel_coords + (tile.scale - 1) // NOTE: offset by 1 px because of 0 indexed
	uv_max.x = uv_max.x / f32(tile_tex.width)
	uv_max.y = uv_max.y / f32(tile_tex.height)

	entity_params := shaders.Entity_Params {
		MODEL  = model,
		UV_MIN = uv_min,
		UV_MAX = uv_max,
	}

	sg.apply_uniforms(
		shaders.UB_entity_params,
		{ptr = &entity_params, size = size_of(entity_params)},
	)

	renderer.quad_mesh.bindings.views[0] = tile_tex.sg_view

	mesh.draw_mesh(&renderer.quad_mesh, 1)
}
