package game_math

vec2 :: [2]f32
vec3 :: [3]f32
vec4 :: [4]f32
mat4 :: matrix[4, 4]f32 // column major by default i.e. stores column1, column2 in sequence memory
vec2i :: [2]i32

/* returns an 4x4 identity matrix

visualized:
[ 1  0  0  0 ]
[ 0  1  0  0 ]
[ 0  0  1  0 ]
[ 0  0  0  1 ]
*/
identity_mat4 :: proc() -> mat4 {
	m: mat4 = {}
	m[0, 0] = 1.0
	m[1, 1] = 1.0
	m[2, 2] = 1.0
	m[3, 3] = 1.0
	return m
}

/* returns an identity 4x4 matrix

visualized:
[ S1  0   0   0 ]
[ 0   S2  0   0 ]
[ 0   0   S3  0 ]
[ 0   0   0   1 ]
*/
scale_mat4 :: proc(scale: vec3) -> mat4 {
	m := identity_mat4()
	m[0].x = scale.x
	m[1].y = scale.y
	m[2].z = scale.z
	return m
}

/* returns a 4x4 matrix that translates a vector into given vector

visualized:
[ 0  0  0  Tx ]
[ 0  0  0  Ty ]
[ 0  0  0  Tz ]
[ 0  0  0   1 ]
*/
translate_mat4 :: proc(translation: vec3) -> mat4 {
	m := identity_mat4()
	m[3].xyz = translation
	return m
}

// learn quaternions for rotation
//
// rotation_mat4
