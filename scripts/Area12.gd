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
    if not Global.monster_introduced:
        get_tree().call_group("friendly_screen", "display")
        yield(get_tree().create_timer(3), "timeout")
        get_tree().call_group("friendly_screen", "hide")
        Global.monster_introduced = true
        yield(say("dear lord...", 2, true), "completed")
    yield(get_tree(), "idle_frame")

func get_description(object_number):
    match object_number:
        object_1.object_number:
            if Global.door_2_open: return "dad, it's supposed to be a scary movie"
            else: return "are you there?"
        object_2.object_number: return "lamp. with batteries. what of it?"
        object_3.object_number: return "cringe"
        object_4.object_number: return "I came through there"
    
func trigger_use(object_number):
    match object_number:
        object_1.object_number:
            if not Global.door_2_open: 
                Global.door_2_open = true
                update_visibilities()
                yield(say("meh", 2, true), "completed")
            else:
                yield(say("we have to try again", 2, true), "completed")
                Global.reset_single_loop()
                switch_areas("Area21")
                get_tree().call_group("monster_screen", "display", "YOU WILL REGRET COMING DOWN HERE")
                yield(get_tree().create_timer(3), "timeout")
                get_tree().call_group("monster_screen", "hide")
        object_2.object_number: yield(say("I don't have a use for batteries right now"), "completed")
        object_3.object_number: yield(switch_areas("Area13"), "completed")
        object_4.object_number: yield(switch_areas("Area11"), "completed")
    yield(get_tree(), "idle_frame")

func update_visibilities():
    $ViewLight.visible = not Global.door_3_open and not Global.gate_3_open and not Global.door_2_open
    $ViewLightDoor3Open.visible = Global.door_3_open and not Global.gate_3_open and not Global.door_2_open
    $ViewLightDoor3Gate3Open.visible = Global.door_3_open and Global.gate_3_open and not Global.door_2_open
    $ViewLightDoor2Open.visible = not Global.door_3_open and not Global.gate_3_open and Global.door_2_open
    $ViewLightDoor2Door3Open.visible = Global.door_3_open and not Global.gate_3_open and Global.door_2_open
    $ViewLightDoor2Door3Gate3Open.visible = Global.door_3_open and Global.gate_3_open and Global.door_2_open
    $Monster.visible = Global.door_2_open
