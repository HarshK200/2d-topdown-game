@header package shaders
@header import sg "topdown_game:third_party/sokol/gfx"
@header import math "topdown_game:internal/game_math"

@ctype mat4 math.mat4


@vs vs
// uniforms set by apply_uniform()
layout(binding=0) uniform frame_params {
    mat4 VIEW;
    mat4 PROJECTION;
};
layout(binding=1) uniform entity_params {
    mat4 MODEL;
    vec2 UV_MIN;
    vec2 UV_MAX;
};

// vertex attributes backed into mesh vertices
in vec3 position;
in vec2 texcoord0;

// attributes that will be sent to fragment shader
out vec2 uv;

void main() {
    // NOTE: gl_Position coordinates MUST be in clip space
    gl_Position = PROJECTION * VIEW * MODEL * vec4(position, 1.0);

    uv = mix(UV_MIN, UV_MAX, texcoord0);
}
@end


@fs fs
// uniforms set by apply_bindings()
layout(binding=0) uniform texture2D fs_tex;
layout(binding=0) uniform sampler fs_smp;

// attributes comming in from vertex shader
in vec2 uv;

// output color
out vec4 out_color;

void main() {
    vec4 tex_color = texture(sampler2D(fs_tex, fs_smp), uv);
    out_color = tex_color;
}
@end

@program default vs fs
