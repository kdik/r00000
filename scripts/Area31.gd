extends R00000Area

onready var object_1 = $Object1
onready var object_2 = $Object2
onready var object_3 = $Object3

func play_fade_in(previous_area):
    return previous_area != null and previous_area != "Area33" and previous_area != "Area23" and previous_area != "Area22"

func play_fade_out(next_area):
    return next_area != "Area32" or Global.monster_introduced or Global.monster_defeated or (not Global.lights_on and not Global.hide_and_seek_started)

func get_initial_rotation(previous_area):
    if previous_area == null: return -55
    elif previous_area == "Area22": return -55
    elif previous_area == "Area23": return -55
    elif previous_area == "Area33": return -55
    elif previous_area == "Area32": return 120
    else: return 0

func get_description(object_number):
    match object_number:
        object_1.object_number: return "go downstairs"
        object_2.object_number: return "exit basement"
        object_3.object_number:
            if Global.lights_on: return "turn light off"
            else: return "turn light on"

func trigger_use(object_number):
    match object_number:
        object_1.object_number:
            if int(Global.loops_completed) == 5:
                get_tree().call_group("main", "game_over", Global.ROOTS)
            else:
                yield(switch_areas("Area32"), "completed")
        object_2.object_number:
            if Global.monster_defeated:
                if Global.door_1_open:
                    get_tree().call_group("main", "game_over", Global.ESCAPE)
                else:
                    Global.door_1_open = true
            else:
                yield(say_yourself("someone locked it!"), "completed")
        object_3.object_number:
            if Global.batteries_removed:
                yield(say_yourself("batteries are missing"), "completed")
            else:
                Global.lights_on = not Global.lights_on
                update_visibilities()
    yield(get_tree(), "idle_frame")

func update_visibilities():
    $ViewLight.visible = Global.lights_on and not Global.door_2_open and not Global.door_1_open
    $ViewLightDoor2Open.visible = Global.lights_on and Global.door_2_open and not Global.door_1_open
    $ViewDark.visible = not Global.lights_on and not Global.door_2_open and not Global.door_1_open
    $ViewDarkDoor2Open.visible = not Global.lights_on and Global.door_2_open and not Global.door_1_open
    $Snow.visible = Global.door_1_open
    $ViewDarkEscape.visible = Global.door_1_open
