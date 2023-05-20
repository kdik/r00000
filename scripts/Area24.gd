extends R00000Area

onready var object_1 = $Object1
onready var object_2 = $Object2
onready var object_3 = $Object2

func get_initial_rotation(previous_area):
    return 30

func get_description(object_number):
    match object_number:
        object_1.object_number: return "the corridor does not seem as cramped"
        object_2.object_number: return "this was not here before"
        object_3.object_number: return "the fuck?!"
    
func trigger_use(object_number):
    match object_number:
        object_1.object_number:
            yield(switch_areas("Area23"), "completed")
        object_2.object_number:
            Global.have_flashlight = true
            update_visibilities()
            get_tree().call_group("player", "acquire_flashlight")
            yield(say("no batteries", 2, true), "completed")
        object_3.object_number:
            yield(say("dad, have you done this?", 2, true), "completed")
    yield(get_tree(), "idle_frame")
    
func update_visibilities():
    $ViewLight.visible = Global.lights_on and Global.have_flashlight and not Global.door_3_open
    $ViewLightFlashlight.visible = Global.lights_on and not Global.have_flashlight and not Global.door_3_open
    $ViewLightDoor3Open.visible = Global.lights_on and Global.have_flashlight and Global.door_3_open
    $ViewLightFlashlightDoor3Open.visible = Global.lights_on and not Global.have_flashlight and Global.door_3_open
    $ViewDark.visible = not Global.lights_on and not Global.door_3_open
    $ViewDarkDoor3Open.visible = not Global.lights_on and Global.door_3_open
    $Graffiti.visible = Global.lights_on
    $Object2.visible = not Global.have_flashlight
    $Object3.visible = Global.lights_on
