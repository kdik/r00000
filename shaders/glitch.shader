shader_type canvas_item;

uniform float wobble_height = 1.0;
uniform float wobble_curve = 1.5;
uniform float wobble_speed = 5.5;
uniform bool on = false;

void vertex()
{
    if (on)
    {
        VERTEX.y += wobble_height * sin(VERTEX.x * wobble_curve + TIME * wobble_speed);
        VERTEX.x += wobble_height * sin(VERTEX.y * wobble_curve + TIME * wobble_speed);
    }
}