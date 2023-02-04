extends Node2D

var own_flashlight = false
var battery_count = 0

func _ready():
    pass
    
func acquire():
    own_flashlight = true

func add_battery():
    if not own_flashlight:
        return
    battery_count += 1
    match battery_count:
        1:
            $Empty.visible = false
            $OneBattery.visible = true
        2:
            $OneBattery.visible = false
            $TwoBatteries.visible = true
        3:
            $TwoBatteries.visible = false
            $ThreeBatteries.visible = true

func is_working():
    return battery_count >= 3
