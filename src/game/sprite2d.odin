package game

import gmath "topdown_game:internal/game_math"
import "topdown_game:src/utils"
Sprite2D :: struct {
	texture_id:   utils.TextureID,
	// these are the texture coordinates in pixels
	// NOTE: These are min_coords, the entity scale can be added to get the max_coords
	texel_coords: gmath.vec2,
}
