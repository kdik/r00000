extends Control

var cheatcode_count = 0
var time = 0

onready var game_over_credits_1 = preload("res://scenes/GameOverCredits1.tscn")
onready var game_over_credits_2 = preload("res://scenes/GameOverCredits2.tscn")
onready var game_over_credits_3 = preload("res://scenes/GameOverCredits3.tscn")

func _ready():
    if Settings.disable_crt: _disable_crt()
    $Static.visible = true
    yield(get_tree().create_timer(1.5), "timeout")
    $Static.visible = false
    var text
    match Global.ending:
        Global.BECOME_EVIL:
            Global.ending_1_achieved = true
            $VideoPlayer1.visible = true
            $VideoPlayer1.play()
            get_tree().call_group("achievements", "unlock_themonsterinme")
        Global.ESCAPE:
            Global.ending_2_achieved = true
            Global.basement_escaped = true
            $VideoPlayer2.visible = true
            $VideoPlayer2.play()
            get_tree().call_group("achievements", "unlock_theend")
        Global.CAUGHT:
            Global.ending_3_achieved = true
            $VideoPlayer3.visible = true
            $VideoPlayer3.play()
            get_tree().call_group("achievements", "unlock_fullstop")
        Global.ROOTS:
            Global.ending_4_achieved = true
            $VideoPlayer4.visible = true
            $VideoPlayer4.play()
            get_tree().call_group("achievements", "unlock_onemoretake")

func _on_ending_video_finished():
    if Global.ending == Global.CAUGHT and cheatcode_count >= 3:
        Global.takes += 1
        Global.lights_on = true
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
        match Global.ending:
            Global.ESCAPE: get_tree().change_scene_to(game_over_credits_1)
            Global.ROOTS: get_tree().change_scene_to(game_over_credits_2)
            Global.BECOME_EVIL: get_tree().change_scene_to(game_over_credits_3)
            Global.CAUGHT: get_tree().change_scene("res://scenes/Menu.tscn")

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
