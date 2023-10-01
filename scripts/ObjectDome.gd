extends Spatial

func _ready():
    add_to_group("object_dome")

func add_object(texture_path, object_number):
    match object_number:
        1: $Dome1.show_object(texture_path)
        2: $Dome2.show_object(texture_path)
        3: $Dome3.show_object(texture_path)
        4: $Dome4.show_object(texture_path)

func clear():
    $Dome1.clear()
    $Dome2.clear()
    $Dome3.clear()
    $Dome4.clear()

func set_initial_rotation(rotation_deg):
    transform.basis = Basis()
    rotate_y(deg2rad(rotation_deg))
