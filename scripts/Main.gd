extends Spatial

onready var current_area = $Areas/Area1

func _ready():
    add_to_group("main")
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
    current_area.on_enter()

func switch_areas(next_area):
    print("Switching to " + next_area)
    get_tree().call_group("audio", "play", "Footsteps")
    get_tree().call_group("ui", "fade_out")
    yield(get_tree().create_timer(0.5), "timeout")
    current_area.on_leave()
    current_area = $Areas.get_node(next_area)
    current_area.on_enter()
    yield(get_tree().create_timer(0.5), "timeout")
    get_tree().call_group("ui", "fade_in")
    yield(get_tree().create_timer(0.5), "timeout")
