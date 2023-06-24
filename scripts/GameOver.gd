extends Spatial

var cheatcode_count = 0
var time = 0

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
    if Global.ending == Global.CAUGHT and cheatcode_count >= 3:
        Global.takes += 1
        Global.reset_single_loop()
        SaveLoad.save()
        $Static.visible = true
        yield(get_tree(), "idle_frame")
        get_tree().change_scene("res://scenes/Main.tscn")
    else:
        Global.takes += 1
        Global.reset()
        SaveLoad.save()
        $Static.visible = true
        yield(get_tree(), "idle_frame")
        get_tree().change_scene("res://scenes/Menu.tscn")
    
func _process(delta):
    time += delta
    if time < 9.2:
        return
    if Global.CAUGHT and Input.is_action_just_pressed("cheatcode"):
        cheatcode_count += 1
        if cheatcode_count == 3:
            $VideoPlayer5.play()
            $VideoPlayer5.visible = true
            $VideoPlayer3.visible = true
            $VideoPlayer3.stop()
