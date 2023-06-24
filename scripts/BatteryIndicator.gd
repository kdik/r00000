extends AnimatedSprite

func _ready():
    add_to_group("battery_indicator")
    update_battery_count()
    
func update_battery_count():
    if not Global.have_flashlight:
        play("no_flashlight")
        return
    match int(Global.battery_count):
        0: play("batteries_0")
        1: play("batteries_1")
        2: play("batteries_2")
        3: play("batteries_3")
