extends R00000Area

onready var object_1 = $Object1
onready var object_2 = $Object2
onready var object_3 = $Object3

func play_fade_in(previous_area):
    return previous_area != null

func play_fade_out(next_area):
    return next_area != "Area12" or Global.monster_introduced_take_1_12

func get_initial_rotation(previous_area):
    if previous_area == null: return -55
    elif previous_area == "Area12": return 120
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
        object_1.object_number: yield(switch_areas("Area12"), "completed")
        object_2.object_number: yield(say_yourself("I can't leave without footage"), "completed")
        object_3.object_number:
            if Global.batteries_removed:
                yield(say_yourself("batteries are missing"), "completed")
            else:
                Global.lights_on = not Global.lights_on
                update_visibilities()
    yield(get_tree(), "idle_frame")

func update_visibilities():
    $ViewLight.visible = not Global.door_2_open
    $ViewLightDoor2Open.visible = Global.door_2_open
    $ViewDark.visible = not Global.lights_on and not Global.door_2_open
    $ViewDarkDoor2Open.visible = not Global.lights_on and Global.door_2_open
