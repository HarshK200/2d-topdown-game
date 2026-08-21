package renderer

import "topdown_game:src/game"

import gmath "topdown_game:internal/game_math"


draw_tilemap :: proc(renderer: ^Renderer, g: ^game.Game2D, texture: Texture2D) {
	// ============================== CHUNK RENDERING ==============================
	player_chunk_coords := game.world_to_chunk_coords(g.player.position)

	// get the chunks around the player with 1 chunk radius and only render those
	chunks_coords_around_player: [dynamic]gmath.vec2i // draw chunks, 8 chunks around the player + 1 chunk below player

	for offset_y in -CHUNK_DRAW_RADIUS ..= CHUNK_DRAW_RADIUS {
		for offset_x in -CHUNK_DRAW_RADIUS ..= CHUNK_DRAW_RADIUS {
			chunk_coord: gmath.vec2i = {i32(offset_x), i32(offset_y)}
			chunk_coord += player_chunk_coords

			// if this chunk_coord exists in the g.world.chunks map then push it in chunks_coords_around_player
			if (chunk_coord in g.world.chunks) {
				append(&chunks_coords_around_player, chunk_coord)
			}
		}
	}

	for chunk_coords in chunks_coords_around_player {
		// the chunk_coords must exist in g.world.chunks map
		assert(chunk_coords in g.world.chunks)
		chunk := &g.world.chunks[chunk_coords]
	}
}


@(private = "file")
draw_chunk :: proc(renderer: ^Renderer, chunk_coordinate: gmath.vec2i, chunk: ^game.Chunk) {
	// TODO: Steps to draw chunk
	// 1. create a chunk tile data array buffer
	// 2. each entry in array buffer will have:
	//      - tile_pos
	//      - tile_scale
	//      - uv_min
	//      - uv_max
	// 3. upload the array buffer to GPU
	// use sg.draw(renderer.quad_mesh.base_element, renderer.quad_mesh.num_elements, INSTANCES HERE)

	// data buffer for this chunk
	chunk_tile_data: any

	for &tiles_row, idx_y in chunk.tiles {
		for &tile, idx_x in tiles_row {
			// tile_coords := gmath.vec2i{i32(idx_x), i32(idx_y)}
		}
	}
}
