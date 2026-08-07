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
Identity_Mat4 :: proc() -> mat4 {
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
Scale_Mat4 :: proc(scale: vec3) -> mat4 {
	m := Identity_Mat4()
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
Translate_Mat4 :: proc(translation: vec3) -> mat4 {
	m := Identity_Mat4()
	m[3].xyz = translation
	return m
}

// learn quaternions for rotation
//
// rotation_mat4


/*
   returns a 4x4 right handed orthographic projection matrix based on os,
   DirectX convention for windows and OpenGL convention for linux
*/
Orthographic_Mat4 :: proc(left, right, bottom, top, near, far: f32) -> mat4 {
	switch {
	case ODIN_OS == .Windows:
		return _Orthographic_Mat4_RH_ZO(left, right, bottom, top, near, far)

	case ODIN_OS == .Linux:
		return _Orthographic_Mat4_RH_NO(left, right, bottom, top, near, far)
	case:
		panic("Unsupported platform")
	}
}

/* retuns a 4x4 right handed orthographic projection matrix with Z ranging from -1 to 1 (OpenGL convention)
   Left, Right, Bottom, Top specify the coordinate of there respective clipping space

visualized:
[ 2.0/width     0           0               -1 ]
[   0       2.0/height      0               -1 ]
[   0           0       2.0/(near - far)    z* ]        z* = (near + far) / (near - far)
[   0           0           0                1 ]
*/
@(private)
_Orthographic_Mat4_RH_NO :: proc(left, right, bottom, top, near, far: f32) -> mat4 {
	m := Identity_Mat4()

	m[0, 0] = 2.0 / (right - left)
	m[1, 1] = 2.0 / (top - bottom)
	m[2, 2] = 2.0 / (near - far)

	m[3].x = (left + right) / (left - right)
	m[3].y = (bottom + top) / (bottom - top)
	m[3].z = (near + far) / (near - far)

	return m
}

/* retuns a 4x4 right handed orthographic projection matrix with Z ranging from 0 to 1 (DirectX/vulkan convention)
   Left, Right, Bottom, Top specify the coordinate of there respective clipping space

visualized:
[ 2.0/width     0           0               -1 ]
[   0       2.0/height      0               -1 ]
[   0           0       1.0/(near - far)    z* ]        z* = (near) / (near - far)
[   0           0           0                1 ]
*/
@(private)
_Orthographic_Mat4_RH_ZO :: proc(left, right, bottom, top, near, far: f32) -> mat4 {
	m := Identity_Mat4()

	m[0, 0] = 2.0 / (right - left)
	m[1, 1] = 2.0 / (top - bottom)
	m[2, 2] = 1.0 / (near - far)

	m[3].x = (left + right) / (left - right)
	m[3].y = (bottom + top) / (bottom - top)
	m[3].z = (near) / (near - far)

	return m
}
