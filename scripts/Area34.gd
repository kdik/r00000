extends R00000Area

onready var object_1 = $Object1
onready var object_2 = $Object2
onready var object_3 = $Object3

func get_initial_rotation(previous_area):
    return -150
    
func init(previous_area):
    if not Global.have_flashlight:
        yield(say_yourself(YouScreen.SOMETHING_DOWN_THERE), "completed")
        return
    yield(get_tree(), "idle_frame")

func get_description(object_number):
    match object_number:
        object_1.object_number: return "crawl back"
        object_2.object_number: return "take flashlight"
        object_3.object_number: return "look closer"
    
func trigger_use(object_number):
    match object_number:
        object_1.object_number: yield(switch_areas("Area33"), "completed")
        object_2.object_number:
            yield(say_monster(MonsterScreen.YOU_WANT_TO_PLAY_WITH_ME), "completed")
            Global.have_flashlight = true
            update_visibilities()
            get_tree().call_group("player", "acquire_flashlight")
            get_tree().call_group("audio_player", "play", "FlashlightPickup")
        object_3.object_number: yield(say_monster(MonsterScreen.TURN_AWAY_NOW), "completed")
    yield(get_tree(), "idle_frame")
    
func update_visibilities():
    $ViewLight.set_visibility(Global.lights_on and Global.have_flashlight and not Global.door_3_open)
    $ViewLightFlashlight.set_visibility(Global.lights_on and not Global.have_flashlight and not Global.door_3_open)
    $ViewLightDoor3Open.set_visibility(Global.lights_on and Global.have_flashlight and Global.door_3_open)
    $ViewLightFlashlightDoor3Open.set_visibility(Global.lights_on and not Global.have_flashlight and Global.door_3_open)
    $ViewDark.set_visibility(not Global.lights_on and not Global.door_3_open)
    $ViewDarkDoor3Open.set_visibility(not Global.lights_on and Global.door_3_open)
    $Graffiti.set_visibility(Global.lights_on)
    get_tree().call_group("object_dome", "clear")
    object_1.set_visibility(true)
    object_2.set_visibility(Global.lights_on and not Global.have_flashlight and not Global.monster_defeated)
    object_3.set_visibility(Global.lights_on and not Global.monster_defeated)
