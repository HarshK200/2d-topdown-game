package game

import gmath "topdown_game:internal/game_math"
import "topdown_game:internal/logger"

Tile :: struct {
	chunk_coords: gmath.vec2,
	tile_typea:   string, // GRASS, DIRT, WATER
	sprite2d:     Sprite2D, // which texture should be used for this tile
}

Chunk :: struct {
	tiles: [16][16]Tile, // 2d array of 16x16 tiles
}

// all the chunk data is store in memory once but render only the closes chunks
World :: struct {
	chunks: map[string]Chunk, // ChunkCoordinate -> Chunk e.g. (3, 4) -> Chunk
}

load_world :: proc(w: ^World) {
	logger.info("Loading game world")

    // TODO: use perlin noise to generate a world i.e. populating the worlds chunks in this function
    // for the passed in world instance. The world generation should follow the rules:
    // 1. Generated world is a limited size like terraria
    // 2. World is divided into 3 major contients: Human, Elf, Demon
    // 3. World shape is Semi-circle like plant tales, dividing the continent into 3 pizza slices and one core in the center
    // 4. Difficulty rises as the player stays away from the core i.e. the Human continent center
}
