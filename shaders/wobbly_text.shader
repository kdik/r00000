shader_type canvas_item;

uniform float wobble_height = 1.0;
uniform float wobble_width = 1.0;
uniform float wobble_curve = 1.5;
uniform float wobble_speed = 5.5;
uniform vec4 color : hint_color = vec4(1, 0, 0, 1);

void fragment()
{
    vec4 tex = texture(TEXTURE, UV);
    tex.rgb = color.rgb;
    COLOR = tex;
}


void vertex()
{
    VERTEX.y += wobble_height * sin(VERTEX.x * wobble_curve + TIME * wobble_speed);
    VERTEX.x += wobble_height * sin(VERTEX.y * wobble_curve + TIME * wobble_speed);
}