extends Control

var finished = false
var time = 0.0

func _ready():
    visible = false

func play_introduction():
    finished = false
    visible = true
    $VideoPlayer.play()
    while not finished:
        yield(get_tree(), "idle_frame")
    $VideoPlayer.stop()
    visible = false

func _on_intro_video_player_finished():
    finished = true
    time = 0.0

func _process(delta):
    if visible:
        time += delta
    if time > 0.5 and Input.is_action_just_pressed("ui_accept"):
        _on_intro_video_player_finished()
