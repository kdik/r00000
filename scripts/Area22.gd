extends R00000Area

onready var object_1 = $Object1
onready var object_2 = $Object2
onready var object_3 = $Object3
onready var object_4 = $Object4

func get_initial_rotation(previous_area):
    if previous_area == "Area23": return 170
    else: return 0
    
func play_fade_out(next_area):
    return next_area != "Area31"

func init(previous_area):
    if not Global.monster_introduced:
        yield(say_monster("I will be the end of you"), "completed")
        yield(say_yourself("he is getting better!"), "completed")
        Global.monster_introduced = true
    yield(get_tree(), "idle_frame")

func get_description(object_number):
    match object_number:
        object_1.object_number:
            if Global.door_2_open: return "go further"
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
                yield(say_yourself("dad?"), "completed")
        object_2.object_number:
            if Global.have_flashlight:
                Global.batteries_removed = true
                Global.lights_on = false
                update_visibilities()
                get_tree().call_group("player", "add_battery")
                yield(get_tree().create_timer(5), "timeout")
                yield(say_yourself("two more left"), "completed")
            else:
                yield(say_yourself("my camera doesn't need them"), "completed")
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
