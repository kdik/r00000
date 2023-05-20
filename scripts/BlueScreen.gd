extends ColorRect

func _ready():
    visible = false
    add_to_group("blue_screen")
    set_pause_mode(PAUSE_MODE_PROCESS)
    
func display():
    get_tree().paused = true
    $RichTextLabel.set_bbcode(_to_code(Global.takes).to_upper())
    visible = true

func hide():
    get_tree().paused = false
    visible = false

func _to_code(number):
    if number < 10: return "R0000" + str(number)
    elif number < 100: return "R000" + str(number)
    elif number < 1000: return "R00" + str(number)
    elif number < 10000: return "R0" + str(number)
    elif number < 100000: return "R" + str(number)
    else: return "WHAT THE HECK"
