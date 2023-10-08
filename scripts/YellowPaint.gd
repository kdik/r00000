extends Node

var enabled = false
var time_passed = 0

func _ready():
    set_pause_mode(PAUSE_MODE_PROCESS)

func enable():
    enabled = true
    
func disable():
    enabled = false

func is_enabled():
    if Settings.yellow_paint: return true
    return enabled

func can_enable():
    if enabled:
        return false
    if not Global.lights_on:
        return false
    if Global.battery_count > 1:
        return false
    if Global.area != "Area31" and Global.area != "Area32" and Global.area != "Area33" and Global.area != "Area34":
        return false
    if Global.ending_1_achieved or Global.ending_2_achieved:
        return false
    return time_passed > 60 * 15

func _process(delta):
    time_passed += delta
