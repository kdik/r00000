extends Spatial

func _ready():
    add_to_group("object_dome")

func add_object(texture_path, object_number):
    if $Dome1.is_free():
        $Dome1.show_object(texture_path, object_number)
    elif $Dome2.is_free():
        $Dome2.show_object(texture_path, object_number)
    elif $Dome3.is_free():
        $Dome3.show_object(texture_path, object_number)
    elif $Dome4.is_free():
        $Dome4.show_object(texture_path, object_number)

func clear():
    $Dome1.clear()
    $Dome2.clear()
    $Dome3.clear()
    $Dome4.clear()

func set_initial_rotation(rotation_deg):
    transform.basis = Basis()
    rotate_y(deg2rad(rotation_deg))
