extends R00000Area

onready var object_1 = $Object1
onready var object_2 = $Object2
onready var object_3 = $Object3
onready var object_4 = $Object4

func get_initial_rotation(previous_area):
    if previous_area == "Area33": return 170
    else: return 0

func init(previous_area):
    if not Global.monster_introduced and Global.lights_on:
        get_tree().call_group("monster_screen", "display", "IT'S ME, BEHIND THE DOOR", "LET ME OUT")
        yield(get_tree().create_timer(3), "timeout")
        get_tree().call_group("monster_screen", "hide")
        Global.monster_introduced = true
    yield(get_tree(), "idle_frame")

func get_description(object_number):
    match object_number:
        object_1.object_number:
            if Global.flashlight_on: return "light destroyed the parasite"
            else: return "an evil presence lurks there"
        object_2.object_number: return "a battery powered light source"
        object_3.object_number: return "the corridor goes a little bit further"
        object_4.object_number: return "upstairs, the door I came through"
    
func trigger_use(object_number):
    match object_number:
        object_1.object_number:
            if not Global.flashlight_on: 
                Global.lights_on = false
                update_visibilities()
            if Global.flashlight_on:
                yield(switch_areas("Area35"), "completed")
            else:
                yield(Monster.introduce(Vector2(-0.19635, -2.159845), "fade_out_near"), "completed")
        object_2.object_number:
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
                        yield(say("two more batteries left to go", 2, true), "completed")
                    elif Global.battery_count == 2:
                        yield(say("one more battery left to go", 2, true), "completed")
                    elif Global.battery_count == 3:
                        say("bingo", 2, true)
                        get_tree().call_group("player", "turn_on_flashlight")
                        get_tree().call_group("monster_eyes", "hide")
                        get_tree().call_group("filter", "hide")
                        Global.flashlight_on = true
                        yield(get_tree().create_timer(3), "timeout")
                else:
                    yield(say("I have no use for the battery I removed", 2, true), "completed")
                yield(Monster.introduce(Vector2(-0.19635, -2.159845), "fade_out_near"), "completed")
        object_3.object_number:
            yield(switch_areas("Area33"), "completed")
        object_4.object_number:
            yield(switch_areas("Area31"), "completed")
    yield(get_tree(), "idle_frame")

func update_visibilities():
    $ViewLight.visible = Global.lights_on and not Global.door_3_open and not Global.gate_3_open
    $ViewLightDoor3Open.visible = Global.lights_on and Global.door_3_open and not Global.gate_3_open
    $ViewLightDoor3Gate3Open.visible = Global.lights_on and Global.door_3_open and Global.gate_3_open
    $ViewDark.visible = not Global.lights_on and not Global.door_3_open and not Global.gate_3_open
    $ViewDarkDoor3Open.visible = not Global.lights_on and Global.door_3_open and not Global.gate_3_open
    $ViewDarkGate3Open.visible = not Global.lights_on and Global.door_3_open and Global.gate_3_open
    object_2.visible = Global.lights_on
    $Monster.visible = not Global.lights_on and not Global.flashlight_on and not Global.hide_and_seek_started
