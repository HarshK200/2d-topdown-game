@header package shaders
@header import sg "../../third_party/sokol/gfx"

@vs vs
in vec3 position;

void main() {
    gl_Position = vec4(position, 1.0);
}
@end

@fs fs
out vec4 out_color;
void main() {
    out_color = vec4(0.596, 1.000, 0.596, 1.0);
}
@end

@program main vs fs
