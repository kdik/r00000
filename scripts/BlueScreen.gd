extends ColorRect

func _ready():
    visible = false
    add_to_group("blue_screen")
    
func show():
    $RichTextLabel.set_bbcode(_to_code(Global.loops_completed).to_upper())
    visible = true
    yield(get_tree().create_timer(2.5), "timeout")
    visible = false

func _to_code(number):
    return "R0000" + str(number)
