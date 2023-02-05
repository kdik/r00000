extends Control

export var text_color : Color = Color(1.0, 1.0, 1.0)

onready var red = $Red
onready var green = $Green
onready var blue = $Blue
onready var main = $Main
onready var red_animation_player = $Red/AnimationPlayer
onready var green_animation_player = $Green/AnimationPlayer
onready var blue_animation_player = $Blue/AnimationPlayer
onready var main_animation_player = $Main/AnimationPlayer

func _ready():
    add_to_group("monster_subtitles")
    red.set_use_bbcode(true)
    green.set_use_bbcode(true)
    blue.set_use_bbcode(true)
    red.material.set_shader_param("color", Color(text_color.r, 0.0, 0.0))
    green.material.set_shader_param("color", Color(0.0, text_color.g, 0.0))
    blue.material.set_shader_param("color", Color(0.0, 0.0, text_color.b))
    main.material.set_shader_param("color", text_color)

func show_subtitles(subtitles, timeout):
    var line = "[right]" + subtitles.to_upper() + "[/right]"
    red.set_bbcode(line)
    green.set_bbcode(line)
    blue.set_bbcode(line)
    main.set_bbcode(line)
    red_animation_player.play("fade_in")
    green_animation_player.play("fade_in")
    blue_animation_player.play("fade_in")
    main_animation_player.play("fade_in")
    yield(get_tree().create_timer(timeout), "timeout")
    red_animation_player.play("fade_out")
    green_animation_player.play("fade_out")
    blue_animation_player.play("fade_out")
    main_animation_player.play("fade_out")
