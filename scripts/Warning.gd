extends Control

onready var studio_animation_player = $Viewport/AnimationPlayer
onready var menu_scene = preload("res://scenes/Menu.tscn")

func _ready():
    if Settings.disable_crt: _disable_crt()
    studio_animation_player.play("fade_in")
    yield(get_tree().create_timer(studio_animation_player.get_animation("fade_in").length + 3), "timeout")
    studio_animation_player.play("fade_out")
    yield(get_tree().create_timer(studio_animation_player.get_animation("fade_out").length), "timeout")
    get_tree().change_scene_to(menu_scene)

func _disable_crt():
    var shift_diff = Vector2(20, 15)
    self.rect_position -= shift_diff
    $CrtCurtain.visible = false
