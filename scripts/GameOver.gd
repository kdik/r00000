extends Control

var cheatcode_count = 0
var time = 0

func _ready():
    if Settings.disable_crt: _disable_crt()
    $Static.visible = true
    yield(get_tree().create_timer(1.5), "timeout")
    $Static.visible = false
    var text
    match Global.ending:
        Global.CAUGHT:
            $VideoPlayer3.visible = true
            $VideoPlayer3.play()
            get_tree().call_group("achievements", "unlock_headache")
        Global.ROOTS:
            $VideoPlayer4.visible = true
            $VideoPlayer4.play()
            get_tree().call_group("achievements", "unlock_onemoretake")
        Global.BECOME_EVIL:
            Global.basement_escaped = true
            $VideoPlayer1.visible = true
            $VideoPlayer1.play()
            get_tree().call_group("achievements", "unlock_themonsterinme")
        Global.ESCAPE:
            Global.basement_escaped = true
            $VideoPlayer2.visible = true
            $VideoPlayer2.play()
            get_tree().call_group("achievements", "unlock_theend")

func _on_ending_video_finished():
    if Global.ending == Global.CAUGHT and cheatcode_count >= 3:
        Global.takes += 1
        Global.reset_single_loop()
        Global.used_cheat_code = true
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
    
func _disable_crt():
    var shift_diff = Vector2(20, 15)
    self.rect_position -= shift_diff
    $CrtCurtain.visible = false    

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
            get_tree().call_group("achievements", "unlock_getalife")
