extends R00000Area

onready var object_1 = $Object1

func get_initial_rotation(previous_area):
    return 30

func get_description(object_number):
    match object_number:
        object_1.object_number: return "crawl back"
    
func trigger_use(object_number):
    match object_number:
        object_1.object_number: yield(switch_areas("Area13"), "completed")
    yield(get_tree(), "idle_frame")
    
func update_visibilities():
    $ViewLight.visible = not Global.door_3_open
    $ViewLightDoor3Open.visible = Global.door_3_open
