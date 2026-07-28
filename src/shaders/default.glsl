@header package shaders
@header import sg "topdown_game:third_party/sokol/gfx"
@header import math "topdown_game:internal/game_math"

@ctype mat4 math.mat4

@vs vs
layout(binding=0) uniform frame_params {
    mat4 VIEW;
    mat4 PROJECTION;
};
layout(binding=1) uniform entity_params {
    mat4 MODEL;
};

in vec3 position;
in vec4 albedo0;

out vec4 albedo;

void main() {
    gl_Position = PROJECTION * VIEW * MODEL * vec4(position, 1.0);
    albedo = albedo0;
}
@end

@fs fs
in vec4 albedo;

out vec4 out_color;

void main() {
    out_color = albedo;
}
@end

@program default vs fs
