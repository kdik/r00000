extends SpotLight

func _ready():
    visible = false

func is_working():
    return Global.battery_count >= 3
