extends Control

var cheatcode_count = 0
var time = 0

onready var game_over_credits_1 = preload("res://scenes/GameOverCredits1.tscn")
onready var game_over_credits_2 = preload("res://scenes/GameOverCredits2.tscn")
onready var game_over_credits_3 = preload("res://scenes/GameOverCredits3.tscn")

func _ready():
    if Settings.disable_crt: _disable_crt()
    if Settings.disable_border: _disable_border()
    yield(_show_static(), "completed")
    var text
    match Global.ending:
        Global.BECOME_EVIL:
            Global.ending_1_achieved = true
            $VideoPlayer1.visible = true
            $VideoPlayer1.play()
            $VideoPlayer1/AudioStreamPlayer.play()
            get_tree().call_group("achievements", "unlock_themonsterinme")
        Global.ESCAPE:
            Global.ending_2_achieved = true
            Global.basement_escaped = true
            $VideoPlayer2.visible = true
            $VideoPlayer2.play()
            $VideoPlayer2/AudioStreamPlayer.play()
            get_tree().call_group("achievements", "unlock_theend")
        Global.CAUGHT:
            Global.ending_3_achieved = true
            if $ControllerChecker.is_controller_connected():
                $VideoPlayer6.visible = true
                $VideoPlayer6.play()   
            else:
                $VideoPlayer3.visible = true
                $VideoPlayer3.play()
            $VideoPlayer3/AudioStreamPlayer.play()
            get_tree().call_group("achievements", "unlock_fullstop")
        Global.ROOTS:
            Global.ending_4_achieved = true
            $VideoPlayer4.visible = true
            $VideoPlayer4.play()
            $VideoPlayer4/AudioStreamPlayer.play()
            get_tree().call_group("achievements", "unlock_onemoretake")

func _on_ending_video_finished():
    match Global.ending:
        Global.BECOME_EVIL: $VideoPlayer1/AudioStreamPlayer.stop()
        Global.ESCAPE: $VideoPlayer2/AudioStreamPlayer.stop()
        Global.CAUGHT: $VideoPlayer3/AudioStreamPlayer.stop()
        Global.ROOTS: $VideoPlayer4/AudioStreamPlayer.stop()
    if Global.ending == Global.CAUGHT and cheatcode_count >= 3:
        Global.takes += 1
        Global.lights_on = true
        Global.reset_single_loop()
        Global.used_cheat_code = true
        SaveLoad.save()
        $Static.visible = true
        get_tree().call_group("audio_player", "play", "NoSignal")        
        yield(get_tree(), "idle_frame")
        get_tree().change_scene("res://scenes/Main.tscn")
    else: 
        Global.takes += 1
        Global.reset()
        SaveLoad.save()
        $Static.visible = true
        get_tree().call_group("audio_player", "play", "NoSignal")        
        yield(get_tree(), "idle_frame")
        match Global.ending:
            Global.ESCAPE: get_tree().change_scene_to(game_over_credits_1)
            Global.ROOTS: get_tree().change_scene_to(game_over_credits_2)
            Global.BECOME_EVIL: get_tree().change_scene_to(game_over_credits_3)
            Global.CAUGHT: get_tree().change_scene("res://scenes/Main.tscn")

func _disable_crt():
    $CrtCurtain.visible = false

func _disable_border():
    var shift_diff = Vector2(20, 15)
    self.rect_position -= shift_diff

func _process(delta):
    time += delta
    if time < 9.2:
        return
    if Global.CAUGHT and Input.is_action_just_pressed("cheatcode"):
        cheatcode_count += 1
        get_tree().call_group("audio_player", "play", "PhoneDial", true)
        if cheatcode_count == 3:
            $VideoPlayer3/AudioStreamPlayer.stop()
            $VideoPlayer5.play()
            $VideoPlayer5.visible = true
            $VideoPlayer3.visible = false
            $VideoPlayer6.visible = false
            $VideoPlayer3.stop()
            $VideoPlayer6.stop()
            get_tree().call_group("achievements", "unlock_getalife")

func _show_static():
    get_tree().call_group("audio_player", "play", "NoSignal")
    $Static.visible = true
    yield(get_tree().create_timer(1.5), "timeout")
    $Static.visible = false
    get_tree().call_group("audio_player", "stop", "NoSignal")
