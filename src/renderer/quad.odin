package renderer

import sg "topdown_game:third_party/sokol/gfx"

@(private)
_make_quad_mesh :: proc() -> Mesh2D {
	quad_mesh: Mesh2D

	// odinfmt: disable
	// quad vertex buffer
	vertices := [?]f32{
		// position			// colors
		-0.5,  0.5, 0.0,		1.0, 0.0, 0.0, 1.0,
		 0.5,  0.5, 0.0,		0.0, 1.0, 0.0, 1.0,
		 0.5, -0.5, 0.0,		0.0, 0.0, 1.0, 1.0,
		-0.5, -0.5, 0.0,		1.0, 1.0, 0.0, 1.0,
	}
	indices := [?]u16 {
		0, 1, 2,
		0, 2, 3,
	}
	// odinfmt: enable

	quad_mesh.base_element = 0
	quad_mesh.num_elements = 6
	quad_mesh.bindings.vertex_buffers[0] = sg.make_buffer(
		{
			label = "Quad Vertex Buffer",
			usage = {vertex_buffer = true, immutable = true},
			data = {ptr = &vertices, size = size_of(vertices)},
		},
	)
	quad_mesh.bindings.index_buffer = sg.make_buffer(
		{
			label = "Quad Index Buffer",
			usage = {index_buffer = true, immutable = true},
			data = {ptr = &indices, size = size_of(indices)},
		},
	)

	return quad_mesh
}
