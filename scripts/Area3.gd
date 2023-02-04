extends Spatial

var door_3_open = false
var gate_3_open = false

func _ready():
    visible = false

func on_enter():
    $ViewLight.visible = Global.lights_on and not door_3_open and not gate_3_open
    $ViewLightDoor3Open.visible = Global.lights_on and door_3_open and not gate_3_open
    $ViewLightDoor3Gate3Open.visible = Global.lights_on and door_3_open and gate_3_open
    $ViewDark.visible = not Global.lights_on and not door_3_open and not gate_3_open
    $ViewDarkDoor3Open.visible = not Global.lights_on and door_3_open and not gate_3_open
    $ViewDarkDoor3Gate3Open.visible = not Global.lights_on and door_3_open and gate_3_open
    visible = true
    add_to_group("area")
    
func on_leave():
    visible = false
    remove_from_group("area")

func on_interact(object_number):
    pass
    
func on_use(object_number):
    pass

func reset():
    pass
