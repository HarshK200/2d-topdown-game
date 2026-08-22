package game

import "core:math"
import "core:math/rand"
import gmath "topdown_game:internal/game_math"
import "topdown_game:internal/logger"
import "topdown_game:src/utils"


// all the chunk data is store in memory once but render only the closes chunks
World :: struct {
	chunks: map[gmath.vec2i]Chunk, // ChunkCoordinate -> Chunk e.g. gmath.vec2{3, 4} -> Chunk
}

TileType :: enum {
	GRASS = 0,
	WATER = 1,
	// DIRT  = 2,
}
Tile :: struct {
	tile_type: TileType, // GRASS, DIRT, WATER
	scale:     gmath.vec2,
	sprite2d:  Sprite2D, // which texture should be used for this tile
}
Chunk :: struct {
	tiles: [utils.CHUNK_SIZE][utils.CHUNK_SIZE]Tile, // 2d array of CHUNK_SIZExCHUNK_SIZE tiles
}

// Generates the game world using noise and populates the passed in world's chunks map
//
// NOTE: no need to call load_world after generate as it populates the world passed in,
// But you do have to save the generated world to a file, this function doesn't do seralization
temp_generate_world :: proc(w: ^World) {
	logger.info("Generating temp game world")


	// TESTING (populating world with random chunk data, only one chunk at (0, 0))
	temp_chunk_coords := [?]gmath.vec2i {
		{0, 0},
		{1, 0},
		{-1, 0},
		{0, 1},
		{0, -1},
		{1, -1},
		{-1, 1},
		{1, 1},
	}

	// no of chunks
	for temp_coord in temp_chunk_coords {
		texture_id := "tilemap_texture_atlas"
		tiles_texture_coords := []gmath.vec2{{0, 0}, {0, 16}, {0, 32}}
		scale := gmath.vec2{utils.TILE_SIZE, utils.TILE_SIZE}


		tiles: [utils.CHUNK_SIZE][utils.CHUNK_SIZE]Tile
		// no of tiles per chunk
		for tile_y in 0 ..< utils.CHUNK_SIZE {
			for tile_x in 0 ..< utils.CHUNK_SIZE {
				tile_type := rand.choice_enum(TileType)
				tiles[tile_y][tile_x] = {
					tile_type = tile_type,
					scale = scale,
					sprite2d = {
						texture_id = texture_id,
						texel_coords = tiles_texture_coords[tile_type],
					},
				}
			}
		}

		w.chunks[temp_coord] = {
			tiles = tiles,
		}
	}

}

// TODO: use perlin noise to generate a world i.e. populating the worlds chunks in this function
// for the passed in world instance. The world generation should follow the rules:
// 1. Generated world is a limited size like terraria
// 2. World is divided into 3 major contients: Human, Elf, Demon
// 3. World shape is Semi-circle like plant tales, dividing the continent into 3 pizza slices and one core in the center
// 4. Difficulty rises as the player stays away from the core i.e. the Human continent center
generate_world :: proc(game: ^Game2D) {
	logger.info("Procedurally generating game world")

}

// load the game world from file and populates the passed in world's chunks map
load_world :: proc(w: ^World) {
}

// converts world space coordinates to chunk space coordinates and returns
//
// NOTE: world coords are 1 unit = 1 pixel
world_to_chunk_coords :: proc(world_coords: gmath.vec2) -> gmath.vec2i {
	result := gmath.Floor(world_coords / (utils.CHUNK_SIZE * utils.TILE_SIZE))
	return {i32(result.x), i32(result.y)}
}

// converts world space coordinates to tile space coordinates and return
world_to_tile_coords :: proc(world_coords: gmath.vec2) -> gmath.vec2i {
	result := gmath.Floor(world_coords / utils.TILE_SIZE)
	return {i32(result.x), i32(result.y)}
}

// takes in a tile_idx and chunk_coords of chunk the tile belongs to and retuns the world coordinates
// NOTE: tile_idx x is left to right and y is top to down, following Y+ Down convention
tile_world_coords :: proc(tile_idx: gmath.vec2i, chunk_coords: gmath.vec2i) -> gmath.vec2 {
	world_coords: gmath.vec2
	world_coords.x = math.floor(
		((f32(chunk_coords.x) * utils.CHUNK_SIZE) + f32(tile_idx.x)) * utils.TILE_SIZE,
	)
	world_coords.y = math.floor(
		((f32(chunk_coords.y) * utils.CHUNK_SIZE) + f32(tile_idx.y)) * utils.TILE_SIZE,
	)

	return world_coords
}
