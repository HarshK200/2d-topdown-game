package mesh

import sg "topdown_game:third_party/sokol/gfx"

Mesh2D :: struct {
	bindings:     sg.Bindings,
	base_element: uint,
	num_elements: uint,
}

// destroy's the GPU buffer containing mesh data
destroy_mesh :: proc(mesh: ^Mesh2D) {
	sg.destroy_buffer(mesh.bindings.vertex_buffers[0])

	if mesh.bindings.index_buffer.id != sg.INVALID_ID {
		sg.destroy_buffer(mesh.bindings.index_buffer)
	}
}
