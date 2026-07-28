package renderer

import sg "topdown_game:third_party/sokol/gfx"

Mesh2D :: struct {
	bindings:     sg.Bindings,
	base_element: uint,
	num_elements: uint,
}

@(private)
// never use _draw_mesh directly in renderer.update() unless testing as its only meant to be used by an _draw_player() or _draw_some_entity()
_draw_mesh :: proc(mesh: ^Mesh2D, instances: uint) {
	sg.apply_bindings(mesh.bindings)
	sg.draw(mesh.base_element, mesh.num_elements, instances)
}

@(private)
_destroy_mesh :: proc(mesh: ^Mesh2D) {
	sg.destroy_buffer(mesh.bindings.vertex_buffers[0])

	if mesh.bindings.index_buffer.id != sg.INVALID_ID {
		sg.destroy_buffer(mesh.bindings.index_buffer)
	}
}
