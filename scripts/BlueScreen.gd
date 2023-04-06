extends ColorRect

func _ready():
    visible = false
    add_to_group("blue_screen")
    set_pause_mode(PAUSE_MODE_PROCESS)
    
func show():
    get_tree().paused = true
    $RichTextLabel.set_bbcode(_to_code(Global.loops_completed).to_upper())
    visible = true
    yield(get_tree().create_timer(2.5), "timeout")
    get_tree().paused = false
    visible = false

func _to_code(number):
    return "R0000" + str(number)
