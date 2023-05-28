extends R00000Area

onready var object_1 = $Object1
onready var object_2 = $Object2
onready var object_3 = $Object3
onready var object_4 = $Object4

func get_initial_rotation(previous_area):
    if previous_area == "Area23": return 170
    else: return 0
    
func play_fade_out(next_area):
    return next_area != "Area31" and (Global.monster_introduced_take_2_23 or next_area != "Area23")

func init(previous_area):
    if not Global.monster_introduced_take_2_12:
        yield(say_monster(MonsterScreen.MISS_ME), "completed")
        Global.monster_introduced_take_2_12 = true
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
                Global.door_2_open = true
                update_visibilities()
            else:
                Global.takes += 1
                Global.reset_single_loop()
                switch_areas("Area31")
                yield(say_yourself(YouScreen.WHOS_TALKING), "completed")
                yield(show_blue_screen(), "completed")
        object_2.object_number:
            Global.batteries_removed = true
            Global.lights_on = false
            update_visibilities()
            if Global.have_flashlight:
                Global.batteries_removed = true
                Global.lights_on = false
                update_visibilities()
                get_tree().call_group("player", "add_battery")
                yield(get_tree().create_timer(4), "timeout")
                yield(say_yourself(YouScreen.TWO_MORE), "completed")
            else:
                yield(say_yourself(-1), "completed")
        object_3.object_number: yield(switch_areas("Area23"), "completed")
        object_4.object_number: yield(switch_areas("Area21"), "completed")
    yield(get_tree(), "idle_frame")

func update_visibilities():
    $ViewLight.visible = Global.lights_on and not Global.door_3_open and not Global.gate_3_open and not Global.door_2_open
    $ViewLightDoor3Open.visible = Global.lights_on and Global.door_3_open and not Global.gate_3_open and not Global.door_2_open
    $ViewLightDoor3Gate3Open.visible = Global.lights_on and Global.door_3_open and Global.gate_3_open and not Global.door_2_open
    $ViewLightDoor2Open.visible = Global.lights_on and not Global.door_3_open and not Global.gate_3_open and Global.door_2_open
    $ViewLightDoor2Door3Open.visible = Global.lights_on and Global.door_3_open and not Global.gate_3_open and Global.door_2_open
    $ViewLightDoor2Door3Gate3Open.visible = Global.lights_on and Global.door_3_open and Global.gate_3_open and Global.door_2_open
    $ViewDark.visible = not Global.lights_on and not Global.door_3_open and not Global.gate_3_open and not Global.door_2_open
    $ViewDarkDoor3Open.visible = not Global.lights_on and Global.door_3_open and not Global.gate_3_open and not Global.door_2_open
    $ViewDarkDoor3Gate3Open.visible = not Global.lights_on and Global.door_3_open and Global.gate_3_open and not Global.door_2_open
    $ViewDarkDoor2Open.visible = not Global.lights_on and not Global.door_3_open and not Global.gate_3_open and Global.door_2_open
    $ViewDarkDoor2Door3Open.visible = not Global.lights_on and Global.door_3_open and not Global.gate_3_open and Global.door_2_open
    $ViewDarkDoor2Door3Gate3Open.visible = not Global.lights_on and Global.door_3_open and Global.gate_3_open and Global.door_2_open
    object_2.visible = Global.lights_on
