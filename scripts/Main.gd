extends Spatial

onready var current_area = $Areas/Area1

func _ready():
    add_to_group("main")
    current_area.on_enter(null)
    
func _process(_delta):
    if Input.is_action_just_pressed("ui_cancel") and OS.get_name() != "HTML5":
        get_tree().paused = true
        $Pause.pause()

func switch_areas(next_area):
    get_tree().call_group("player", "lock_actions")
    
    
    var previous_area = current_area.name
    print("Switching to " + next_area + " from " + previous_area)
    if previous_area != "Area3" or next_area != "Area1":
        get_tree().call_group("audio", "play", "Footsteps")
        get_tree().call_group("ui", "fade_out")
        yield(get_tree().create_timer(0.5), "timeout")
    current_area.on_leave(next_area)
    get_tree().call_group("player", "reset_position")
    if previous_area != "Area3" or next_area != "Area1":    
        yield(get_tree().create_timer(0.5), "timeout")
        get_tree().call_group("ui", "fade_in")
        
        
    
    current_area = $Areas.get_node(next_area)
    yield(current_area.on_enter(previous_area), "completed")
    yield(get_tree().create_timer(0.5), "timeout")
    
    
    
    
    
    get_tree().call_group("player", "unlock_actions")

func game_over():
    get_tree().call_group("player", "lock_actions")
    get_tree().reload_current_scene()
    Global.reset()
    get_tree().change_scene("res://scenes/GameOver.tscn")
