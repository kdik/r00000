shader_type canvas_item;

uniform float alpha = 0.0;

void fragment()
{
    vec4 tex = texture(TEXTURE, UV);
    tex.a = alpha;
    COLOR = tex;
}