extends AnimatedSprite

func _ready():
    visible = false

func _process(_delta):
    var loops_completed = int(Global.loops_completed)
    if loops_completed > 0: visible = true
    match loops_completed:
        1: if not is_playing(): 
            play("level_1")
            _play_roots_audio(loops_completed)
        2: if get_animation() != "level_2": 
            play("level_2")
            _play_roots_audio(loops_completed)
        3: if get_animation() != "level_3": 
            play("level_3")
            _play_roots_audio(loops_completed)
        4: if get_animation() != "level_4": 
            play("level_4")
            _play_roots_audio(loops_completed)
        5: if get_animation() != "level_5": 
            play("level_5")
            _play_roots_audio(loops_completed)

func _play_roots_audio(loops_completed):
    $Roots1.stop()
    $Roots2.stop()
    $Roots3.stop()
    $Roots4.stop()
    $Roots5.stop()
    $Roots6.stop()
    match loops_completed:
        1: $Roots1.play()
        2: $Roots2.play()
        3: $Roots3.play()
        4: $Roots4.play()
        5: $Roots5.play()
        6: $Roots5.play()
