extends Camera

func _ready():
    add_to_group("hidden_detector_camera")

func set_object_number(object_number):
    set_cull_mask_bit(9 + object_number, true)

func object_in_sight():
    var pixel_data = get_viewport().get_texture().get_data()
    pixel_data.lock()
    var pixel_opacity = int(pixel_data.get_pixel(320, 240).a)
    pixel_data.unlock()
    return pixel_opacity > 0

func rotate_with_main_camera(rotation_x, rotation_y):
    transform.basis = Basis()
    rotate_x(rotation_x)
    rotate_y(rotation_y)
