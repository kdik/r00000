extends ColorRect

var left_eye_near = Vector2(0.566, 0.544)
var right_eye_near = Vector2(0.608, 0.545)
var eye_near_radius = 0.01
var eye_near_radius_solid = 0.001
var left_eye_far = Vector2(0.557, 0.45)
var right_eye_far = Vector2(0.581, 0.45)
var eye_far_radius = 0.005
var eye_far_radius_solid = 0.001
var left_eye_follow = Vector2(0.23, 0.455)
var right_eye_follow = Vector2(0.35, 0.455)
var eye_follow_radius = 0.03
var eye_follow_radius_solid = 0.015

func _ready():
    visible = false
    add_to_group("monster_eyes")
    
func fade_out_near():
    material.set_shader_param("left_eye", left_eye_near)
    material.set_shader_param("right_eye", right_eye_near)
    material.set_shader_param("radius", eye_near_radius)
    material.set_shader_param("radius_solid", eye_near_radius_solid)
    visible = true
    $AnimationPlayer.play("fade_out")
    yield(get_tree().create_timer($AnimationPlayer.get_animation("fade_out").length), "timeout")

func fade_out_far():
    material.set_shader_param("left_eye", left_eye_far)
    material.set_shader_param("right_eye", right_eye_far)
    material.set_shader_param("radius", eye_far_radius)
    material.set_shader_param("radius_solid", eye_far_radius_solid)
    visible = true
    $AnimationPlayer.play("fade_out")
    yield(get_tree().create_timer($AnimationPlayer.get_animation("fade_out").length), "timeout")
    
func fade_in():
    material.set_shader_param("left_eye", left_eye_follow)
    material.set_shader_param("right_eye", right_eye_follow)
    material.set_shader_param("radius_solid", eye_follow_radius_solid)
    visible = true
    $AnimationPlayer.play("fade_in")
    yield(get_tree().create_timer($AnimationPlayer.get_animation("fade_in").length), "timeout")
