extends SpotLight

func _ready():
    visible = false
    
func acquire():
    Global.own_flashlight = true

func add_battery():
    if not Global.own_flashlight:
        return
    Global.battery_count += 1
    if is_working():
        visible = true

func is_working():
    return Global.battery_count >= 3
