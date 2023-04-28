shader_type spatial;
render_mode unshaded;

uniform sampler2D view_texture;
uniform sampler2D texture_1;
uniform sampler2D texture_2;
uniform float speed = 0.03;
uniform float wobble_height = 1.0;
uniform float wobble_width = 10.0;
uniform float wobble_curve = 5.0;
uniform float wobble_speed = 0.1;

void fragment() {
    if (texture(view_texture, UV).a < 0.9) {
        discard;
    }
    
    vec2 uv_1 = UV + vec2(0.01 * sin(TIME), - speed * TIME);
    vec2 uv_2 = UV + vec2(0.01 * cos(TIME), - speed * TIME);
    vec4 tex_1 = texture(texture_1, uv_1);
    vec4 tex_2 = texture(texture_2, uv_2);
    vec4 tex = vec4(min(tex_1.r + tex_2.r, 1.0), min(tex_1.r + tex_2.r, 1.0), min(tex_1.g + tex_2.g, 1.0), min(tex_1.a + tex_2.a, 1.0));
    ALBEDO = tex.rgb;
    ALPHA = tex.a;
}