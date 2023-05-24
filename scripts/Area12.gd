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
        yield(say_dad("booooooooooo!"), "completed")
        yield(say_yourself("dad, you have to act\nharder next time"), "completed")
        Global.monster_introduced = true
    yield(get_tree(), "idle_frame")

func get_description(object_number):
    match object_number:
        object_1.object_number: return "open the forsaken doors"
        object_2.object_number: return "take batteries"
        object_3.object_number: return "go further"
        object_4.object_number: return "go upstairs"
    
func trigger_use(object_number):
    match object_number:
        object_1.object_number:
            Global.takes += 1
            Global.reset_single_loop()
            switch_areas("Area21")
            yield(say_dad("fuck, the damn doors are stuck"), "completed")
            yield(say_yourself("cut!"), "completed")
        object_2.object_number: yield(say_yourself("my camera doesn't need them"), "completed")
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
