extends Control

onready var current_area

func _ready():
    add_to_group("main")
    if Settings.disable_crt: _disable_crt()
    if Global.have_flashlight: get_tree().call_group("player", "acquire_flashlight")
    if Global.flashlight_on: get_tree().call_group("player", "turn_on_flashlight")
    Monster.on_load()
    current_area = $Areas.get_node(Global.area)
    current_area.on_enter(null)
    get_tree().call_group("audio_player", "stop", "NoSignal")
    
func _process(_delta):
    if Input.is_action_just_pressed("ui_cancel"):
        get_tree().paused = true
        $Pause.pause()

func switch_areas(next_area):
    var previous_area = current_area.name
    print("Switching to " + next_area + " from " + previous_area)
    yield(current_area.on_leave(next_area), "completed")
    get_tree().call_group("player", "reset_position")
    current_area = $Areas.get_node(next_area)
    Global.area = next_area
    SaveLoad.save()
    yield(current_area.on_enter(previous_area), "completed")

func game_over(ending):
    get_tree().call_group("player", "lock_actions")
    get_tree().reload_current_scene()
    Global.ending = ending
    get_tree().change_scene("res://scenes/GameOver.tscn")

func _disable_crt():
    var shift_diff = Vector2(20, 15)
    self.rect_position -= shift_diff
    $CrtCurtain.visible = false
