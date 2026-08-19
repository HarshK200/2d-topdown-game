package mesh

import sg "topdown_game:third_party/sokol/gfx"

make_triangle_mesh :: proc() -> Mesh2D {
	triangle_mesh: Mesh2D
	
	// odinfmt: disable
	// triangle vertex buffer NOTE: FOLLOWS Y+ "Down" CONVENTION
	vertices := [?]f32 {
	     // position		// texcoords
		 0.0, -0.5, 0.0,	0.5, 0.0,   // top-middle
		-0.5,  0.5, 0.0,	0.0, 1.0,   // bottom-left
		 0.5,  0.5, 0.0,	1.0, 1.0    // bottom-right
	}
	indices := [?]u16 {
		0, 1, 2,
	}
	// odinfmt: enable

	triangle_mesh.base_element = 0
	triangle_mesh.num_elements = len(indices)
	triangle_mesh.bindings.vertex_buffers[0] = sg.make_buffer(
		{
			label = "Triangle Vertex Buffer",
			usage = {vertex_buffer = true, immutable = true},
			data = {ptr = &vertices, size = size_of(vertices)},
		},
	)
	triangle_mesh.bindings.index_buffer = sg.make_buffer(
		{
			label = "Triangle Index Buffer",
			usage = {index_buffer = true, immutable = true},
			data = {ptr = &indices, size = size_of(indices)},
		},
	)
	// default sampler
	triangle_mesh.bindings.samplers[0] = sg.make_sampler({})

	return triangle_mesh
}
