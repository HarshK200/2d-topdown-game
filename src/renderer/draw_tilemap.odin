package renderer

import "topdown_game:src/game"
import "topdown_game:src/utils"

import gmath "topdown_game:internal/game_math"
import sg "topdown_game:third_party/sokol/gfx"


TileInstanceData :: struct {
	tile_pos:   gmath.vec2,
	tile_scale: gmath.vec2,
	uv_min:     gmath.vec2,
	uv_max:     gmath.vec2,
}

draw_tilemap :: proc(renderer: ^Renderer, g: ^game.Game2D, texture: Texture2D) {
	// ============================== CHUNK RENDERING ==============================
	player_chunk_coords := game.world_to_chunk_coords(g.player.position)

	// data buffer for all the visble chunk around player chunk radius
	tile_instances_data := make([dynamic]TileInstanceData, 0, context.temp_allocator)
	reserve(&tile_instances_data, utils.MAX_VISIBLE_TILES)

	// get the chunks around the player with utils.CHUNK_RENDER_RADIUS and only render those
	chunks_coords_around_player := make([dynamic]gmath.vec2i, 0, context.temp_allocator)

	for offset_y in -utils.CHUNK_RENDER_RADIUS ..= utils.CHUNK_RENDER_RADIUS {
		for offset_x in -utils.CHUNK_RENDER_RADIUS ..= utils.CHUNK_RENDER_RADIUS {
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


		for &tiles_row, idx_y in chunk.tiles {
			for &tile, idx_x in tiles_row {
				assert(texture.id == tile.sprite2d.texture_id)

				// push this tile data to tile_instances_data array
				tile_idx := gmath.vec2i{i32(idx_x), i32(idx_y)}

				tile_pos := game.tile_world_coords(tile_idx, chunk_coords)
				tile_scale := tile.scale
				uv_min := tile.sprite2d.texel_coords / {f32(texture.width), f32(texture.height)}
				uv_max :=
					(tile.sprite2d.texel_coords + (tile.scale - 1)) /
					{f32(texture.width), f32(texture.height)}

				tile_data: TileInstanceData = {
					tile_pos   = tile_pos,
					tile_scale = tile_scale,
					uv_min     = uv_min,
					uv_max     = uv_max,
				}

				append(&tile_instances_data, tile_data)
			}
		}
	}


	// NOTE: if there is no tile to draw then don't draw
	if (len(tile_instances_data) <= 0) {
		return
	}
	// upload the instance array buffer to GPU
	sg.update_buffer(
		renderer.quad_mesh.bindings.vertex_buffers[1],
		data = {
			ptr = raw_data(tile_instances_data),
			size = len(tile_instances_data) * size_of(TileInstanceData),
		},
	)

	// draw the instances
	sg.draw(
		renderer.quad_mesh.base_element,
		renderer.quad_mesh.num_elements,
		len(tile_instances_data),
	)
}

make_tilemap_instance_buffer :: proc(renderer: ^Renderer) -> sg.Buffer {
	// upload the instance array buffer to GPU
	buf := sg.make_buffer(
		{
			label = "Tile Instance Buffer",
			usage = {vertex_buffer = true, immutable = false, dynamic_update = true},
			size = utils.MAX_VISIBLE_TILES * size_of(TileInstanceData),
		},
	)

	return buf
}
