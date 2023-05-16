extends R00000Area

onready var object_1 = $Object1
onready var object_2 = $Object2
onready var object_3 = $Object3

func play_fade_in(previous_area):
    return previous_area != null and previous_area != "Area03" and previous_area != "Area02"

func get_initial_rotation(previous_area):
    if previous_area == null or previous_area == "Area03" or previous_area == "Area02": return -55
    elif previous_area == "Area12": return 120
    else: return 0

func get_description(object_number):
    match object_number:
        object_1.object_number: return "he could at least try to be scary"
        object_2.object_number: return "I can't show this footage to the guys"
        object_3.object_number: return "it would be cool to film in the dark"

func trigger_use(object_number):
    match object_number:
        object_1.object_number: yield(switch_areas("Area12"), "completed")
        object_2.object_number: yield(say("no quitting", 2, true), "completed")
        object_3.object_number: yield(say("if I had a night vision camera, which I do not", 2, true), "completed")
    yield(get_tree(), "idle_frame")

func update_visibilities():
    $ViewLight.visible = true
