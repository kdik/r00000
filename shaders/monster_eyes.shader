shader_type canvas_item;

uniform vec2 left_eye = vec2(0.25, 0.5);
uniform vec2 right_eye = vec2(0.75, 0.5);
uniform float radius = 0.1;
uniform float solid_radius = 0.01;
uniform vec4 color : hint_color = vec4(1, 1, 1, 1);

void fragment()
{
    vec2 adjusted_uv = UV * vec2(1.0, 0.75) + vec2(0.0, 0.125);
    float distance_to_left = distance(adjusted_uv, left_eye);
    float distance_to_right = distance(adjusted_uv, right_eye);
    vec4 tex = vec4(color.rgb, 0.0);
    if (distance_to_left < solid_radius || distance_to_right < solid_radius)
    {
        tex.a = 1.0;
    } 
    else
    {
        float alpha_left = 0.0;
        float alpha_right = 0.0;
        if (distance_to_left < radius)
        {
            alpha_left = (radius - distance_to_left) / (radius - solid_radius);
        }
        if (distance_to_right < radius)
        {
            alpha_right = (radius - distance_to_right) / (radius - solid_radius);
        }
        tex.a = max(alpha_left, alpha_right);
    }
    COLOR = tex;
}