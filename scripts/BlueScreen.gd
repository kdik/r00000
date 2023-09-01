extends ColorRect

func _ready():
    visible = false
    add_to_group("blue_screen")
    set_pause_mode(PAUSE_MODE_PROCESS)
    
func start_showing():
    get_tree().call_group("gameplay_audio_player", "pause")
    get_tree().paused = true
    $RichTextLabel.set_bbcode(_to_code(Global.takes).to_upper())
    visible = true
    if int(Global.takes) >= 100:
        get_tree().call_group("achievements", "unlock_r00100")

func stop_showing():
    get_tree().paused = false
    visible = false
    get_tree().call_group("gameplay_audio_player", "resume")

func _to_code(number):
    if number < 10: return "R0000" + str(number)
    elif number < 100: return "R000" + str(number)
    elif number < 1000: return "R00" + str(number)
    elif number < 10000: return "R0" + str(number)
    elif number < 100000: return "R" + str(number)
    else: return "WHAT THE HECK"
