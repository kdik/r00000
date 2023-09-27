extends Control

onready var menu_scene = preload("res://scenes/Menu.tscn")

func _ready():
    $VideoPlayer.play()
    $VideoPlayer/AudioStreamPlayer.play()

func _on_video_player_finished():
    get_tree().change_scene_to(menu_scene)
    
func _process(_delta):
    if Input.is_action_just_pressed("ui_accept"):
        _on_video_player_finished()
