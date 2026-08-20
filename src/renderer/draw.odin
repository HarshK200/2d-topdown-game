package renderer

import "core:slice"
import gmath "topdown_game:internal/game_math"
import shaders "topdown_game:src/shaders/build"
import sg "topdown_game:third_party/sokol/gfx"


DrawCommand :: struct {
	pos:           gmath.vec2,
	texture_id:    string,
	entity_params: shaders.Entity_Params,
}

// Draws all the accumulated draw commands in the draw queue for a layer,
// Ignores Y sorting on this layers draws if ignore_sorting is true
//
// NOTE: Y sorting is done on Y+ Down convention
DrawLayer :: proc(renderer: ^Renderer, ignore_sorting: bool, layer_texture_id: string) {
	// Y sorting
	if !ignore_sorting {
		slice.sort_by(renderer.draw_queue[:], proc(a, b: DrawCommand) -> bool {
			return a.pos.y < b.pos.y
		})
	}

	mesh := renderer.quad_mesh
	mesh.bindings.views[0] = renderer.textures[layer_texture_id].sg_view
	sg.apply_bindings(mesh.bindings)

	// render sorted draw_queue
	for i in 0 ..< len(renderer.draw_queue) {
		draw_cmd := renderer.draw_queue[i]
		assert(
			layer_texture_id == draw_cmd.texture_id,
			"Texture id of draw command didn't match the current layer spritesheet texture_id",
		)

		sg.apply_uniforms(
			shaders.UB_entity_params,
			{ptr = &draw_cmd.entity_params, size = size_of(draw_cmd.entity_params)},
		)

		// make the draw call
		sg.draw(mesh.base_element, mesh.num_elements, 1)
	}
}
