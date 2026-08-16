package game

import gmath "topdown_game:internal/game_math"
import "topdown_game:internal/logger"

TILE_SIZE :: 16 // 16x16 pixels
CHUNK_SIZE :: 16 // 16x16 tiles

TileType :: enum {
	GRASS,
	DIRT,
	WATER,
}

Tile :: struct {
	tile_type:    TileType, // GRASS, DIRT, WATER
	chunk_coords: gmath.vec2,
	scale:        gmath.vec2,
	sprite2d:     Sprite2D, // which texture should be used for this tile
}

Chunk :: struct {
	tiles: [16][16]Tile, // 2d array of 16x16 tiles
}

// all the chunk data is store in memory once but render only the closes chunks
World :: struct {
	chunks: map[gmath.vec2i]Chunk, // ChunkCoordinate -> Chunk e.g. gmath.vec2{3, 4} -> Chunk
}

// Generates the game world using noise and populates the passed in world's chunks map
load_world :: proc(w: ^World) {
	logger.info("Loading game world")

	// TODO: use perlin noise to generate a world i.e. populating the worlds chunks in this function
	// for the passed in world instance. The world generation should follow the rules:
	// 1. Generated world is a limited size like terraria
	// 2. World is divided into 3 major contients: Human, Elf, Demon
	// 3. World shape is Semi-circle like plant tales, dividing the continent into 3 pizza slices and one core in the center
	// 4. Difficulty rises as the player stays away from the core i.e. the Human continent center


	// TESTING (populating world with random chunk data, only one chunk at (0, 0))
	// TODO: use noise to generate world instead
    // odinfmt: disable
	w.chunks[{0, 0}] = {
		tiles = {
            // Row 0
            {
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {32, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {16, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {16, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {16, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {16, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
            },
            // Row 1
            {
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
            },
            // Row 2
            {
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
            },
            // Row 3
            {
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
            },
            // Row 4
            {
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
            },
            // Row 5
            {
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
            },
            // Row 6
            {
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
            },
            // Row 7
            {
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
            },
            // Row 8
            {
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
            },
            // Row 9
            {
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
            },
            // Row 10
            {
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
            },
            // Row 11
            {
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
            },
            // Row 12
            {
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
            },
            // Row 13
            {
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
            },
            // Row 14
            {
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
            },
            // Row 15
            {
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {0, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
                {chunk_coords = {0, 0}, tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "GrassTileMap", texel_coords = {64, 0}}},
            },
        },
	}
    // odinfmt: enable
}

// converts world space coordinates to chunk space coordinates and returns
//
// NOTE: world coords are 1 unit = 1 pixel
world_to_chunk_coords :: proc(world_coords: gmath.vec2) -> gmath.vec2i {
	result := gmath.Floor(world_coords / (CHUNK_SIZE * TILE_SIZE))
	return {i32(result.x), i32(result.y)}
}

// converts world space coordinates to tile space coordinates and return
world_to_tile_coords :: proc(world_coords: gmath.vec2) -> gmath.vec2 {
	return gmath.Floor(world_coords / TILE_SIZE)
}

// takes in a tile_idx and chunk_coords of chunk the tile belongs to and retuns the world coordinates
//
// NOTE: tile_idx follows (row, column) format
tile_world_coords :: proc(tile_idx: gmath.vec2, chunk_coords: gmath.vec2) -> gmath.vec2 {
	world_coords: gmath.vec2
	// NOTE TO SELF: tile_idx.y and tile_idx.x are correct they are flipped because (row, column) format is used
	world_coords.x = ((chunk_coords.x * CHUNK_SIZE) + tile_idx.y) * TILE_SIZE
	world_coords.y = ((chunk_coords.y * CHUNK_SIZE) + tile_idx.x) * TILE_SIZE

	return world_coords
}
