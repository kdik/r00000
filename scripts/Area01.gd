extends R00000Area

onready var object_1 = $Object1
onready var object_2 = $Object2
onready var object_3 = $Object3

func play_fade_in(previous_area):
    return previous_area != null

func get_initial_rotation(previous_area):
    if previous_area == null: return -55
    elif previous_area == "Area02": return 120
    else: return 0

func get_description(object_number):
    match object_number:
        object_1.object_number: return "ok, take one, here we go!"
        object_2.object_number: return "I can't leave without any footage"
        object_3.object_number: return "I could turn it off but I won't see shit"

func trigger_use(object_number):
    match object_number:
        object_1.object_number: yield(switch_areas("Area02"), "completed")
        object_2.object_number: yield(say("nope, not going without my monster movie", 2, true), "completed")
        object_3.object_number: yield(say("tempting, but no", 2, true), "completed")
    yield(get_tree(), "idle_frame")
