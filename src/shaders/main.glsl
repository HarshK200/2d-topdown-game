@header package shaders
@header import sg "topdown_game:third_party/sokol/gfx"

@vs vs
in vec3 position;
in vec4 albedo0;

out vec4 albedo;

void main() {
    gl_Position = vec4(position, 1.0);
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

@program main vs fs
