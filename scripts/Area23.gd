extends R00000Area

onready var object_1 = $Object1
onready var object_2 = $Object2
onready var object_3 = $Object3
onready var object_4 = $Object4

func play_fade_out(next_area):
    return next_area != "Area31" and (Global.have_flashlight or next_area != "Area24")

func get_initial_rotation(previous_area):
    if previous_area == "Area22": return 135
    else: return 0

func init(previous_area):
    if not Global.monster_introduced_take_2_23:
        yield(say_monster(MonsterScreen.DONT_YOU_WORRY), "completed")
        Global.monster_introduced_take_2_23 = true
    yield(get_tree(), "idle_frame")

func get_description(object_number):
    match object_number:
        object_1.object_number: return "go back"
        object_2.object_number: return "crawl deeper"
        object_3.object_number:
            if not Global.door_3_open: return "open doors"
            elif not Global.gate_3_open: return "open gates"
            else: return "retake footage"
        object_4.object_number: return "take batteries"

func trigger_use(object_number):
    match object_number:
        object_1.object_number: yield(switch_areas("Area22"), "completed")
        object_2.object_number: yield(switch_areas("Area24"), "completed")
        object_3.object_number:
            if not Global.door_3_open:
                Global.door_3_open = true
                get_tree().call_group("audio_player", "play", "DoorRegular")
            elif not Global.gate_3_open:
                Global.gate_3_open = true
                get_tree().call_group("audio_player", "play", "DoorMetal")
            else:
                Global.takes += 1
                Global.loops_completed += 1
                Global.lights_on = true
                Global.reset_single_loop()
                switch_areas("Area31")
                yield(say_monster(MonsterScreen.YOUR_VIDEO_IS_A_DISGRACE), "completed")
                yield(say_monster(MonsterScreen.START_OVER_NOW), "completed")
                if Global.lights_on: yield($"../../Rewind".play($"../../Rewind".VIDEO_1), "completed")
                else: yield($"../../Rewind".play($"../../Rewind".VIDEO_1_1), "completed")
                yield(show_blue_screen(), "completed")
        object_4.object_number:
            if Global.have_flashlight:
                Global.batteries_removed = true
                Global.lights_on = false
                update_visibilities()
                get_tree().call_group("player", "add_battery")
                yield(get_tree().create_timer(4), "timeout")
                yield(say_yourself(YouScreen.TWO_MORE), "completed")
            else:
                Global.batteries_removed = true
                Global.lights_on = false
                update_visibilities()
                yield(say_yourself(YouScreen.I_CANNOT_USE_THEM_RIGHT_NOW), "completed")
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
    get_tree().call_group("decal_dome", "clear")
    $DecalGraffiti.set_visibility(Global.lights_on)
    $DecalFlashlight.set_visibility(Global.lights_on and not Global.have_flashlight)
    get_tree().call_group("object_dome", "clear")
    object_1.set_visibility(true)
    object_2.set_visibility(true)
    object_3.set_visibility(true)
    object_4.set_visibility(Global.lights_on)
