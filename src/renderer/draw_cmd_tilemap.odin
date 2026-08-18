package renderer

import "topdown_game:internal/logger"
import "topdown_game:src/game"

import gmath "topdown_game:internal/game_math"
import shaders "topdown_game:src/shaders/build"


append_draw_cmd_tilemap :: proc(renderer: ^Renderer, g: ^game.Game2D) {

	// ============================== CHUNK RENDERING ==============================
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
	reserve(&chunks_coords_around_player, len(neighbour_chunk))
	for n, i in neighbour_chunk {
		chunk_coords := player_chunk_coords + n
		if chunk_coords not_in g.world.chunks {
			continue
		}
		append(&chunks_coords_around_player, chunk_coords)
	}

	// pre allocate space for draw commands
	required_draw_calls := len(chunks_coords_around_player) * game.CHUNK_SIZE * game.CHUNK_SIZE
	reserve(&renderer.draw_queue, len(renderer.draw_queue) + required_draw_calls)

	for coords in chunks_coords_around_player {
		chunk := &g.world.chunks[coords]
		assert(coords in g.world.chunks) // coords must exist in the world chunk array due to previous check

		for &tile_row, idx_y in chunk.tiles {
			for &tile, idx_x in tile_row {
				append_draw_cmd_tile(renderer, &tile, {i32(idx_x), i32(idx_y)}, coords)
			}
		}
	}

}

@(private = "file")
append_draw_cmd_tile :: proc(
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

	draw_cmd: DrawCommand = {
		pos          = tile_world_pos, // not required to specify position since no Y sorting needed, i just put it cause i had it
		texture_id   = tile_tex.texture_id,
		entityParams = entity_params,
	}

	append(&renderer.draw_queue, draw_cmd)
}
