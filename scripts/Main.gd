extends Spatial

onready var current_area

func _ready():
    add_to_group("main")
    SaveLoad.init()
    if Global.have_flashlight: get_tree().call_group("player", "acquire_flashlight")
    if Global.flashlight_on: get_tree().call_group("player", "turn_on_flashlight")
    current_area = $Areas.get_node(Global.area)
    current_area.on_enter(null)
    
func _process(_delta):
    if Input.is_action_just_pressed("ui_cancel") and OS.get_name() != "HTML5":
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
    Global.takes += 1
    Global.reset()
    Global.ending = ending
    SaveLoad.save()
    get_tree().change_scene("res://scenes/GameOver.tscn")
