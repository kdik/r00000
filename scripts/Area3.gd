extends R00000Area

onready var object_1 = $Object1
onready var object_2 = $Object2
onready var object_3 = $Object3
onready var object_4 = $Object4

func play_fade_out(next_area):
    return next_area != "Area1"

func get_initial_rotation(previous_area):
    if previous_area == "Area2": return 135
    else: return 0

func get_description(object_number):
    match object_number:
        object_1.object_number: return "the corridor goes a little bit back"
        object_2.object_number: return "a small nook under the staircase"
        object_3.object_number:
            if not Global.door_3_open: return "a door"
            elif not Global.gate_3_open: return "a gate"
            else: return "a passageway"
        object_4.object_number: return "a battery powered light source"

func trigger_use(object_number):
    match object_number:
        object_1.object_number:
            get_tree().call_group("main", "switch_areas", "Area2")
        object_2.object_number:
            get_tree().call_group("main", "switch_areas", "Area4")
        object_3.object_number:
            if not Global.door_3_open:
                Global.door_3_open = true
            elif not Global.gate_3_open:
                Global.gate_3_open = true
            else:
                Global.loops_completed += 1
                Global.reset_single_loop()
                get_tree().call_group("blue_screen", "show")
                yield(get_tree().create_timer(2.5), "timeout")
                get_tree().call_group("blue_screen", "hide")
                get_tree().call_group("main", "switch_areas", "Area1")
                get_tree().call_group("monster_eyes", "hide")
                get_tree().call_group("filter", "hide")
        object_4.object_number:
            if Global.batteries_removed:
                yield(say("I have no use for more batteries"), "completed")
            elif Global.batteries_removed:
                yield(say("the light source has no batteries"), "completed")
            else:
                Global.batteries_removed = true
                Global.lights_on = false
                update_visibilities()
                if Global.have_flashlight and Global.battery_count < 3:
                    get_tree().call_group("player", "add_battery")
                    yield(get_tree().create_timer(3), "timeout")
                    if Global.battery_count == 1:
                        yield(say("two more batteries left to go"), "completed")
                    elif Global.battery_count == 2:
                        yield(say("one more battery left to go"), "completed")
                    elif Global.battery_count == 3:
                        say("bingo")
                        get_tree().call_group("player", "turn_on_flashlight")
                        get_tree().call_group("monster_eyes", "hide")
                        get_tree().call_group("filter", "hide")
                        Global.flashlight_on = true
                        yield(get_tree().create_timer(3), "timeout")
                else:
                    yield(say("I have no use for the battery I removed"), "completed")
                yield(Monster.introduce(Vector2(-0.1309, 2.552544), "fade_out_far"), "completed")
    yield(get_tree(), "idle_frame")

func update_visibilities():
    $ViewLight.visible = Global.lights_on and not Global.door_3_open and not Global.gate_3_open
    $ViewLightDoor3Open.visible = Global.lights_on and Global.door_3_open and not Global.gate_3_open
    $ViewLightDoor3Gate3Open.visible = Global.lights_on and Global.door_3_open and Global.gate_3_open
    $ViewDark.visible = not Global.lights_on and not Global.door_3_open and not Global.gate_3_open
    $ViewDarkDoor3Open.visible = not Global.lights_on and Global.door_3_open and not Global.gate_3_open
    $ViewDarkGate3Open.visible = not Global.lights_on and Global.door_3_open and Global.gate_3_open
    $Graffiti.visible = Global.lights_on
    object_4.visible = Global.lights_on
    $Monster.visible = not Global.lights_on and not Global.flashlight_on and not Global.hide_and_seek_started
