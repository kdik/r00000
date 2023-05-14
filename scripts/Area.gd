class_name R00000Area
extends Spatial

func _ready():
    visible = false

func get_description(object_number):
    return ""

func on_interact(object_number):
    get_tree().call_group("player_subtitles", "show_subtitles", get_description(object_number))

func _rotate_self_on_start(rotation_deg):
    transform.basis = Basis()
    rotate_y(deg2rad(rotation_deg))

func on_enter(previous_area):
    pass

func on_leave(next_area):
    visible = false
    remove_from_group("area")
