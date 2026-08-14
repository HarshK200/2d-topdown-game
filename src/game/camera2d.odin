package game

import gmath "topdown_game:internal/game_math"

Camera2D :: struct {
	position: gmath.vec2,
	near:     f32,
	far:      f32,
	// todo add rotation
}

init_camera :: proc(g: ^Game2D) {
	g.camera.position = {0.0, 0.0} // centering the camera on player i.e. at (0, 0) i.e. topleft
	// TODO: check if it is fine to have -1 and 1 as near/far values when using D3D11
	g.camera.near = -1
	g.camera.far = 1
}

/*
    A simple view matrix for 2d camera
    NOTE: 3D cameras use a lookat matrix to construct a view matrix as they have orientation as well, it
    is not required for a simple 2D camera though

    TODO: add camera rotation
    NOTE: keep in mind when adding rotation since view matrix is inverse of camera transformation
    we reverse the order of SRT i.e. it becomes TRS i.e. Translate * Rotate * Scale
*/
view_matrix_from_camera2d :: proc(camera: ^Camera2D) -> gmath.mat4 {
	view_mat := gmath.Translate_Mat4({-camera.position.x, -camera.position.y, 0.0})

	return view_mat
}

inv_view_matrix_from_camera2d :: proc(camera: ^Camera2D) -> gmath.mat4 {
	view_mat := gmath.Translate_Mat4({camera.position.x, camera.position.y, 0.0})

	return view_mat
}
