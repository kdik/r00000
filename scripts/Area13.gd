extends R00000Area

onready var object_1 = $Object1
onready var object_2 = $Object2
onready var object_3 = $Object3
onready var object_4 = $Object4

func play_fade_out(next_area):
    return next_area != "Area21"

func get_initial_rotation(previous_area):
    if previous_area == "Area12": return 135
    else: return 0

func get_description(object_number):
    match object_number:
        object_1.object_number: return "sound was coming from there"
        object_2.object_number: return "these walls lack some creepy visuals"
        object_3.object_number:
            if not Global.door_3_open: return "someone there?"
            elif not Global.gate_3_open: return "looks good on camera, but where is the monster?"
            else: return "same old nothing!"
        object_4.object_number: return "lamp. with batteries. what of it?"

func trigger_use(object_number):
    match object_number:
        object_1.object_number: yield(switch_areas("Area12"), "completed")
        object_2.object_number: yield(switch_areas("Area14"), "completed")
        object_3.object_number:
            if not Global.door_3_open:
                Global.door_3_open = true
            elif not Global.gate_3_open:
                Global.gate_3_open = true
            else:
                Global.takes += 1
                Global.reset_single_loop()
                switch_areas("Area21")
                get_tree().call_group("monster_screen", "start_showing", "YOU WILL REGRET COMING DOWN HERE")
                yield(get_tree().create_timer(3), "timeout")
                get_tree().call_group("monster_screen", "stop_showing")
        object_4.object_number: yield(say("I don't have a use for batteries right now", 2, true), "completed")
    yield(get_tree(), "idle_frame")

func update_visibilities():
    $ViewLight.visible = not Global.door_3_open and not Global.gate_3_open and not Global.door_2_open
    $ViewLightDoor3Open.visible = Global.door_3_open and not Global.gate_3_open and not Global.door_2_open
    $ViewLightDoor3Gate3Open.visible = Global.door_3_open and Global.gate_3_open and not Global.door_2_open
    $ViewLightDoor2Open.visible = not Global.door_3_open and not Global.gate_3_open and Global.door_2_open
    $ViewLightDoor2Door3Open.visible = Global.door_3_open and not Global.gate_3_open and Global.door_2_open
    $ViewLightDoor2Door3Gate3Open.visible = Global.door_3_open and Global.gate_3_open and Global.door_2_open
    $Monster.visible = Global.door_2_open
