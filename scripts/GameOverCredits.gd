extends Control

var credits_finished = false
var time = 0.0

func _ready():
    if Settings.disable_crt: _disable_crt()
    if Settings._disable_border: _disable_border()
    yield(_show_static(), "completed")
    $PostCreditsVideoPlayer.visible = false
    $CreditsVideoPlayer.play()
    while not credits_finished:
        yield(get_tree(), "idle_frame")
    yield(_show_static(), "completed")
    $PostCreditsVideoPlayer.play()
    $CreditsVideoPlayer.visible = false
    $PostCreditsVideoPlayer.visible = true

func _on_credits_video_player_finished():
    credits_finished = true

func _on_post_credits_video_player_finished():
    yield(_show_static(), "completed")
    get_tree().change_scene("res://scenes/Menu.tscn")

func _process(delta):
    time += delta
    if time > 0.5 and Input.is_action_just_pressed("ui_accept"):
        _on_post_credits_video_player_finished()

func _disable_crt():
    $CrtCurtain.visible = false

func _disable_border():
    var shift_diff = Vector2(20, 15)
    self.rect_position -= shift_diff

func _show_static():
    get_tree().call_group("audio_player", "play", "NoSignal")
    $Static.visible = true
    yield(get_tree().create_timer(1.5), "timeout")
    $Static.visible = false
    get_tree().call_group("audio_player", "stop", "NoSignal")
