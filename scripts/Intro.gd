extends Spatial

onready var viewport_animation_player = $ViewportTexture/AnimationPlayer
onready var studio_animation_player = $Viewport/StudioNameLabel/AnimationPlayer
onready var menu_scene = preload("res://scenes/Menu.tscn")

func _ready():
    viewport_animation_player.play("turn_on")
    yield(get_tree().create_timer(viewport_animation_player.get_animation("turn_on").length), "timeout")
    studio_animation_player.play("fade_in")
    yield(get_tree().create_timer(studio_animation_player.get_animation("fade_in").length + 1), "timeout")
    studio_animation_player.play("fade_out")
    yield(get_tree().create_timer(studio_animation_player.get_animation("fade_out").length), "timeout")
    get_tree().change_scene_to(menu_scene)
