extends R00000Area

onready var object_1 = $Object1
onready var object_2 = $Object2
onready var object_3 = $Object3

func play_fade_in(previous_area):
    return previous_area != null and previous_area != "Area13" and previous_area != "Area12"

func play_fade_out(next_area):
    return next_area != "Area22" or Global.monster_introduced

func get_initial_rotation(previous_area):
    if previous_area == null or previous_area == "Area13" or previous_area == "Area12": return -55
    elif previous_area == "Area22": return 120
    else: return 0

func get_description(object_number):
    match object_number:
        object_1.object_number: return "damn, he is getting better!"
        object_2.object_number: return "what I have is decent"
        object_3.object_number:
            if Global.lights_on: return "lights out!"
            else: return "dear light!"

func trigger_use(object_number):
    match object_number:
        object_1.object_number: yield(switch_areas("Area22"), "completed")
        object_2.object_number: yield(say("but not good enough to call it quits", 2, true), "completed")
        object_3.object_number: 
            Global.lights_on = not Global.lights_on
            update_visibilities()
            if Global.lights_on: yield(say("phew!", 2, true), "completed")
            else: yield(say("creepyness level 10000!", 2, true), "completed")
    yield(get_tree(), "idle_frame")

func update_visibilities():
    $ViewLight.visible = Global.lights_on and not Global.door_2_open
    $ViewLightDoor2Open.visible = Global.lights_on and Global.door_2_open
    $ViewDark.visible = not Global.lights_on and not Global.door_2_open
    $ViewDarkDoor2Open.visible = not Global.lights_on and Global.door_2_open
