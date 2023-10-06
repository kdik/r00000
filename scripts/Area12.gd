extends R00000Area

onready var object_1 = $Object1
onready var object_2 = $Object2
onready var object_3 = $Object3
onready var object_4 = $Object4

func get_initial_rotation(previous_area):
    if previous_area == "Area13": return 170
    else: return 0
    
func play_fade_out(next_area):
    return next_area != "Area21"

func init(previous_area):
    if not Global.monster_introduced_take_1_12:
        yield(say_monster(MonsterScreen.HELLO_MY_DEAR), "completed")
        Global.monster_introduced_take_1_12 = true
    yield(get_tree(), "idle_frame")

func get_description(object_number):
    match object_number:
        object_1.object_number: 
            if Global.door_2_open: return "retake footage"
            else: return "open the forsaken doors"
        object_2.object_number: return "take batteries"
        object_3.object_number: return "go further"
        object_4.object_number: return "go upstairs"
    
func trigger_use(object_number):
    match object_number:
        object_1.object_number:
            if not Global.door_2_open:
                get_tree().call_group("audio_player", "play", "DoorRegular")
                Global.door_2_open = true
                update_visibilities()
            else:
                yield(say_yourself(YouScreen.WHOS_TALKING), "completed")
                if Global.lights_on: yield($"../../Rewind".play($"../../Rewind".VIDEO_2), "completed")
                else: yield($"../../Rewind".play($"../../Rewind".VIDEO_2_1), "completed")
                Global.takes += 1
                Global.lights_on = true
                Global.reset_single_loop()
                switch_areas("Area21")                
                yield(show_blue_screen(), "completed")
        object_2.object_number:
            Global.batteries_removed = true
            Global.lights_on = false
            update_visibilities()
            yield(say_yourself(YouScreen.I_CANNOT_USE_THEM_RIGHT_NOW), "completed")
        object_3.object_number: yield(switch_areas("Area13"), "completed")
        object_4.object_number: yield(switch_areas("Area11"), "completed")
    yield(get_tree(), "idle_frame")

func update_visibilities():
    $ViewLight.set_visibility(Global.lights_on and not Global.door_3_open and not Global.gate_3_open and not Global.door_2_open)
    $ViewLightDoor3Open.set_visibility(Global.lights_on and Global.door_3_open and not Global.gate_3_open and not Global.door_2_open)
    $ViewLightDoor3Gate3Open.set_visibility(Global.lights_on and Global.door_3_open and Global.gate_3_open and not Global.door_2_open)
    $ViewLightDoor2Open.set_visibility(Global.lights_on and not Global.door_3_open and not Global.gate_3_open and Global.door_2_open)
    $ViewLightDoor2Door3Open.set_visibility(Global.lights_on and Global.door_3_open and not Global.gate_3_open and Global.door_2_open)
    $ViewLightDoor2Door3Gate3Open.set_visibility(Global.lights_on and Global.door_3_open and Global.gate_3_open and Global.door_2_open)
    $ViewDark.set_visibility(not Global.lights_on and not Global.door_3_open and not Global.gate_3_open and not Global.door_2_open)
    $ViewDarkDoor3Open.set_visibility(not Global.lights_on and Global.door_3_open and not Global.gate_3_open and not Global.door_2_open)
    $ViewDarkDoor3Gate3Open.set_visibility(not Global.lights_on and Global.door_3_open and Global.gate_3_open and not Global.door_2_open)
    $ViewDarkDoor2Open.set_visibility(not Global.lights_on and not Global.door_3_open and not Global.gate_3_open and Global.door_2_open)
    $ViewDarkDoor2Door3Open.set_visibility(not Global.lights_on and Global.door_3_open and not Global.gate_3_open and Global.door_2_open)
    $ViewDarkDoor2Door3Gate3Open.set_visibility(not Global.lights_on and Global.door_3_open and Global.gate_3_open and Global.door_2_open)
    get_tree().call_group("object_dome", "clear")
    object_1.set_visibility(true)
    object_2.set_visibility(Global.lights_on)
    object_3.set_visibility(true)
    object_4.set_visibility(true)
