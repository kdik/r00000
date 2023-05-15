extends Spatial

func _ready():
    $Static.visible = true
    yield(get_tree().create_timer(1.5), "timeout")
    $Static.visible = false
    var text
    match Global.ending:
        Global.CAUGHT:
            $VideoPlayer3.visible = true
            $VideoPlayer3.play()
        Global.ROOTS:
            $VideoPlayer4.visible = true
            $VideoPlayer4.play()
        Global.BECOME_EVIL:
            $VideoPlayer1.visible = true
            $VideoPlayer1.play()
        Global.ESCAPE:
            $VideoPlayer2.visible = true
            $VideoPlayer2.play()

func _on_ending_video_finished():
    $Static.visible = true
    yield(get_tree(), "idle_frame")
    get_tree().change_scene("res://scenes/Menu.tscn")
