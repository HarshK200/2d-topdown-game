package game

import gmath "topdown_game:internal/game_math"
import "topdown_game:internal/logger"


// all the chunk data is store in memory once but render only the closes chunks
World :: struct {
	chunks: map[gmath.vec2i]Chunk, // ChunkCoordinate -> Chunk e.g. gmath.vec2{3, 4} -> Chunk
}

TILE_SIZE :: 16 // 16x16 pixels
CHUNK_SIZE :: 16 // 16x16 tiles
TileType :: enum {
	GRASS,
	DIRT,
	WATER,
}
Tile :: struct {
	tile_type: TileType, // GRASS, DIRT, WATER
	scale:     gmath.vec2,
	sprite2d:  Sprite2D, // which texture should be used for this tile
}
Chunk :: struct {
	tiles: [CHUNK_SIZE][CHUNK_SIZE]Tile, // 2d array of CHUNK_SIZExCHUNK_SIZE tiles
}

// Generates the game world using noise and populates the passed in world's chunks map
//
// NOTE: no need to call load_world after generate as it populates the world passed in,
// But you do have to save the generated world to a file, this function doesn't do seralization
generate_world :: proc(w: ^World) {
}

// load the game world from file and populates the passed in world's chunks map
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
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {16, 0}}},
            },
            // Row 1
            {
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {16, 0}}},
            },
            // Row 2
            {
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {16, 0}}},
            },
            // Row 3
            {
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {16, 0}}},
            },
            // Row 4
            {
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {16, 0}}},
            },
            // Row 5
            {
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {16, 0}}},
            },
            // Row 6
            {
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {16, 0}}},
            },
            // Row 7
            {
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {16, 0}}},
            },
            // Row 8
            {
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {16, 0}}},
            },
            // Row 9
            {
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {16, 0}}},
            },
            // Row 10
            {
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {16, 0}}},
            },
            // Row 11
            {
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {16, 0}}},
            },
            // Row 12
            {
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {16, 0}}},
            },
            // Row 13
            {
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {16, 0}}},
            },
            // Row 14
            {
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {16, 0}}},
            },
            // Row 15
            {
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {64, 0}}},
                {tile_type = .GRASS, scale = {16, 16}, sprite2d = {texture_id = "layer0_spritesheet", texel_coords = {0, 0}}},
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
world_to_tile_coords :: proc(world_coords: gmath.vec2) -> gmath.vec2i {
	result := gmath.Floor(world_coords / TILE_SIZE)
	return {i32(result.x), i32(result.y)}
}

// takes in a tile_idx and chunk_coords of chunk the tile belongs to and retuns the world coordinates
// NOTE: tile_idx x is left to right and y is top to down, following Y+ Down convention
tile_world_coords :: proc(tile_idx: gmath.vec2i, chunk_coords: gmath.vec2i) -> gmath.vec2 {
	world_coords: gmath.vec2
	world_coords.x = ((f32(chunk_coords.x) * CHUNK_SIZE) + f32(tile_idx.x)) * TILE_SIZE
	world_coords.y = ((f32(chunk_coords.y) * CHUNK_SIZE) + f32(tile_idx.y)) * TILE_SIZE

	return world_coords
}
