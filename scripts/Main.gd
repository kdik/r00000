extends Spatial

onready var current_area = $Areas/Area1

func _ready():
    add_to_group("main")
    get_tree().call_group("ui", "fade_in")
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
    current_area.on_enter(null)
    
func _process(_delta):
    if Input.is_action_just_pressed("ui_cancel"):
        get_tree().quit()

func switch_areas(next_area):
    print("Switching to " + next_area)
    get_tree().call_group("audio", "play", "Footsteps")
    get_tree().call_group("ui", "fade_out")
    yield(get_tree().create_timer(0.5), "timeout")
    var previous_area = current_area.name
    current_area.on_leave(next_area)
    get_tree().call_group("player", "lock_actions")
    get_tree().call_group("player", "reset_position")
    get_tree().call_group("player", "reset_object_in_sight")
    yield(get_tree().create_timer(0.5), "timeout")
    get_tree().call_group("ui", "fade_in")
    current_area = $Areas.get_node(next_area)
    var on_enter_state = current_area.on_enter(previous_area)
    if on_enter_state is GDScriptFunctionState: yield(on_enter_state, "completed")
    yield(get_tree().create_timer(0.5), "timeout")
    get_tree().call_group("player", "unlock_actions")

func game_over():
    get_tree().call_group("player", "lock_actions")
    get_tree().call_group("ui", "fade_out")
    yield(get_tree().create_timer(1.5), "timeout")
    get_tree().reload_current_scene()
    Global.reset()
    get_tree().change_scene("res://scenes/GameOver.tscn")
