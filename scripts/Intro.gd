extends Control

onready var viewport_animation_player = $ViewportTexture/AnimationPlayer
onready var studio_animation_player = $Viewport/StudioNameLabel/AnimationPlayer
onready var warning_scene = preload("res://scenes/Warning.tscn")

func _ready():
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
    if Settings.disable_crt: _disable_crt()
    if Settings.disable_border: _disable_border()
    viewport_animation_player.play("turn_on")
    yield(get_tree().create_timer(viewport_animation_player.get_animation("turn_on").length), "timeout")
    studio_animation_player.play("fade_in")
    yield(get_tree().create_timer(studio_animation_player.get_animation("fade_in").length + 1), "timeout")
    studio_animation_player.play("fade_out")
    yield(get_tree().create_timer(studio_animation_player.get_animation("fade_out").length), "timeout")
    get_tree().change_scene_to(warning_scene)

func _disable_crt():
    $CrtCurtain.visible = false
    
func _disable_border():
    get_viewport().set_size(Vector2(640, 480))
    var shift_diff = Vector2(20, 15)
    self.rect_position -= shift_diff
