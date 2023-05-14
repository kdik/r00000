class_name R00000Area
extends Spatial

func _ready():
    visible = false

# functions overriden by extended class
# -------------------------------------
func update_visibilities():
    pass
    
func init(previous_area):
    pass

func get_description(object_number):
    return ""
    
func get_initial_rotation(previous_area):
    return 0
# -------------------------------------

func on_interact(object_number):
    get_tree().call_group("player_subtitles", "show_subtitles", get_description(object_number))

func rotate_self_on_start(rotation_deg):
    transform.basis = Basis()
    rotate_y(deg2rad(rotation_deg))

func on_enter(previous_area):
    rotate_self_on_start(get_initial_rotation(previous_area))
    init(previous_area)
    update_visibilities()
    add_to_group("area")
    visible = true
    yield(get_tree(), "idle_frame")

func on_leave(next_area):
    visible = false
    remove_from_group("area")
