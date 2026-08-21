package renderer

import "topdown_game:src/game"
import sg "topdown_game:third_party/sokol/gfx"

CHUNK_DRAW_RADIUS :: 1

DrawTilemapLayer :: proc(renderer: ^Renderer, g: ^game.Game2D) {
	// set the texture_atlas for tilemap layer
    texture := renderer.textures["tilemap_texture_atlas"]
    renderer.quad_mesh.bindings.views[0] = texture.sg_view
    sg.apply_bindings(renderer.quad_mesh.bindings)

    draw_tilemap(renderer, g, texture)
}

DrawEntityLayer :: proc(renderer: ^Renderer, g: ^game.Game2D) {
	// set the texture_atlas for entity layer
	texture := renderer.textures["entity_texture_atlas"]
	renderer.quad_mesh.bindings.views[0] = texture.sg_view
	sg.apply_bindings(renderer.quad_mesh.bindings)


	draw_player(renderer, g, texture)
}
