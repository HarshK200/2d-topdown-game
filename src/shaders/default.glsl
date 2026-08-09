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
    vec2 UV_MIN;
    vec2 UV_MAX;
};

in vec3 position;
in vec4 albedo0;
in vec2 texcoord0;

out vec4 albedo;
out vec2 uv;

void main() {
    gl_Position = PROJECTION * VIEW * MODEL * vec4(position, 1.0);

    albedo = albedo0;
    uv = mix(UV_MIN, UV_MAX, texcoord0);
}
@end


@fs fs
layout(binding=0) uniform texture2D fs_tex;
layout(binding=0) uniform sampler fs_smp;

in vec4 albedo;
in vec2 uv;

out vec4 out_color;

void main() {
    vec4 tex_color = texture(sampler2D(fs_tex, fs_smp), uv);
    out_color = tex_color;
}
@end

@program default vs fs
