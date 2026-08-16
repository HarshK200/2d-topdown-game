package game_math

import "core:math"
vec2 :: [2]f32
vec3 :: [3]f32
vec4 :: [4]f32
mat4 :: matrix[4, 4]f32 // column major by default i.e. stores column1, column2 in sequence memory
vec2i :: [2]i32

// normalize a vector
Normalize :: proc {
	normalize_vec2,
}

// floor
Floor :: proc {
	floor_vec2,
}

// normalizes a vec2
@(private)
normalize_vec2 :: proc(v: vec2) -> vec2 {
	vec_len := math.sqrt(math.pow(v.x, 2) + math.pow(v.y, 2))
	// fix divide by zero bug
	if vec_len == 0 {
		return {0, 0}
	}
	normalized := v / vec_len
	return normalized
}

// floor a vec2
@(private)
floor_vec2 :: proc(v: vec2) -> vec2 {
	result: vec2
	result.x = math.floor(v.x)
	result.y = math.floor(v.y)

	return result
}

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

/* retuns a 4x4 right handed orthographic projection matrix with Z ranging from -1 to 1 (OpenGL convention)
   Left, Right, Bottom, Top specify the coordinate of there respective clipping space
   NOTE: THIS FOLLOWS Y+ "Down" CONVENTION

visualized:
[ 2.0/width     0           0               -1 ]
[   0       2.0/height      0               -1 ]
[   0           0       2.0/(near - far)    z* ]        z* = (near + far) / (near - far)
[   0           0           0                1 ]

    WARNING: OpenGL is not supported yet this projection matrix is just for testing purposes
*/
Orthographic_Mat4_RH_NO :: proc(left, right, bottom, top, near, far: f32) -> mat4 {
	m := Identity_Mat4()

	m[0, 0] = 2.0 / (right - left)
	m[1, 1] = 2.0 / (top - bottom)
	m[2, 2] = 2.0 / (near - far)
	m[3, 3] = 1.0

	m[3].x = (left + right) / (left - right)
	m[3].y = (bottom + top) / (bottom - top)
	m[3].z = (near + far) / (near - far)

	return m
}

/* retuns a 4x4 right handed orthographic projection matrix with Z ranging from 0 to 1 (DirectX/vulkan convention)
   Left, Right, Bottom, Top specify the coordinate of there respective clipping space
   NOTE: THIS FOLLOWS Y+ "Down" CONVENTION

visualized:
[ 2.0/width     0           0               -1 ]
[   0       2.0/height      0               -1 ]
[   0           0       1.0/(near - far)    z* ]        z* = (near) / (near - far)
[   0           0           0                1 ]
*/
Orthographic_Mat4_RH_ZO :: proc(left, right, bottom, top, near, far: f32) -> mat4 {
	m := Identity_Mat4()

	m[0, 0] = 2.0 / (right - left)
	m[1, 1] = 2.0 / (top - bottom)
	m[2, 2] = 1.0 / (near - far)
	m[3, 3] = 1.0

	m[3].x = (left + right) / (left - right)
	m[3].y = (bottom + top) / (bottom - top)
	m[3].z = (near) / (near - far)

	return m
}

// Returns an inverse for the given orthographic projection matrix. Works for all orthographic
// projection matrices, regardless of handedness or NDC convention.
//
// TODO: i understand the scaling part but what's with the third coloumn? i.e. translation?
InvOrthographic_Mat4 :: proc(OrthoMatrix: mat4) -> mat4 {
	result := Identity_Mat4()

	result[0, 0] = 1.0 / OrthoMatrix[0, 0]
	result[1, 1] = 1.0 / OrthoMatrix[1, 1]
	result[2, 2] = 1.0 / OrthoMatrix[2, 2]
	result[3, 3] = 1.0

	result[3].x = -OrthoMatrix[3].x * result[0, 0]
	result[3].y = -OrthoMatrix[3].y * result[1, 1]
	result[3].z = -OrthoMatrix[3].z * result[2, 2]

	return result
}
