shader_type canvas_item;

uniform float time = 0.0;
uniform vec4 color : hint_color = vec4(1, 1, 1, 1);

void fragment()
{
    vec4 tex = texture(TEXTURE, UV);
    tex.rgb = color.rgb;
    if (time < 1.57)
    {
        tex.a *= min(1.0, sin(time));
    }
    COLOR = tex;
}