@header package shaders
@header import sg "topdown_game:third_party/sokol/gfx"
@header import math "topdown_game:internal/game_math"

@ctype mat4 math.mat4


// =========================== VERTEX SHADER ===========================
@vs vs
// uniforms set by apply_uniform()
layout(binding=0) uniform tilemap_frame_params {
    mat4 VIEW;
    mat4 PROJECTION;
};

// vertex attributes baked into mesh vertices
in vec3 quad_pos;
in vec2 quad_texcoords;

out vec2 uv;

void main() {
    // TODO: make the MODEL matrix
    gl_Position = PROJECTION * VIEW * vec4(quad_pos, 1.0);
    uv = quad_texcoords;
}
@end

// =========================== FRAGMENT SHADER ===========================
@fs fs
// uniforms set by apply_bindings()
layout(binding=0) uniform texture2D tilemap_fs_tex;
layout(binding=0) uniform sampler tilemap_fs_smp;

// attributes comming in from vertex shader
in vec2 uv;

// output color
out vec4 out_color;

void main() {
    vec4 tex_color = texture(sampler2D(tilemap_fs_tex, tilemap_fs_smp), uv);
    // discard completely trasparent values
    if (tex_color.a < 0.001) {
        discard;
    }

    // TODO: just multiply the tex_color.a with opacity. get opacity from uniform data
    out_color = tex_color;
}
@end

@program tilemap vs fs
