extends VideoPlayer

func _ready():
    add_to_group("menu_filter")

func start_playing():
    if not is_playing(): play()
    $AnimationPlayer.play("fade_in")
    yield(get_tree().create_timer($AnimationPlayer.get_animation("fade_in").length + 0.2), "timeout")
    
func stop_playing():
    $AnimationPlayer.play("fade_out")
    yield(get_tree().create_timer($AnimationPlayer.get_animation("fade_out").length), "timeout")
    if is_playing(): stop()

func _on_finished():
    play()
