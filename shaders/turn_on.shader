shader_type canvas_item;

uniform float time : hint_range(0.0, 10.0) = 1.5;
uniform float time_point_1 = 0.5;
uniform float time_point_2 = 1.0;
uniform float time_point_3 = 1.5;
uniform float starting_size = 0.025;
uniform float half_resolution_x = 320.0;
uniform float half_resolution_y = 256.0;

void fragment(){
    if (time < time_point_3) {
       COLOR.rgb = texture(TEXTURE, UV).rgb;
    } else {
       COLOR.rgb = texture(TEXTURE, UV).rgb;
    }
}

void vertex()
{
    if (time < time_point_1)
    {
        float size = starting_size * time / time_point_1;
        VERTEX.y = half_resolution_y * (1.0 - size) + VERTEX.y * size;
        VERTEX.x = half_resolution_x * (1.0 - size) + VERTEX.x * size
    }
    else if (time < time_point_2) {
        float multiplier = starting_size + (time - time_point_1) / (time_point_2 - time_point_1);
        if (multiplier > 1.0)
        {
            multiplier = 1.0;
        }
        VERTEX.y = half_resolution_y * (1.0 - starting_size) + VERTEX.y * starting_size;
        VERTEX.x = half_resolution_x * (1.0 - multiplier) + VERTEX.x * multiplier;
    }
    else if (time < time_point_3) {
        float multiplier = starting_size + (time - time_point_2) / (time_point_3 - time_point_2);
        if (multiplier > 1.0)
        {
            multiplier = 1.0;
        }
        VERTEX.y = half_resolution_y * (1.0 - multiplier) + VERTEX.y * multiplier;
    }
}