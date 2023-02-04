extends Camera

var rotation_speed = PI / 48
var rotation_x = 0
var rotation_y = 0
var object_in_sight_number
onready var hidden_detector_viewport = $HiddenDetectorViewport
onready var hidden_detector_camera = $HiddenDetectorViewport/HiddenDetectorCamera

func _process(_delta):
    if Input.is_action_pressed("ui_left"):
        rotation_y += rotation_speed
        _update_rotation()
    elif Input.is_action_pressed("ui_right"):
        rotation_y -= rotation_speed
        _update_rotation()
    elif Input.is_action_pressed("ui_up"):
        rotation_x += rotation_speed
        _update_rotation()
    elif Input.is_action_pressed("ui_down"):
        rotation_x -= rotation_speed
        _update_rotation()    
    elif Input.is_action_just_pressed("ui_accept"):
        _use()
    elif Input.is_action_just_pressed("ui_select"):
        _interact()    

func _update_rotation():
    rotation_x = clamp(rotation_x, -0.25 * PI, 0.25 * PI)
    transform.basis = Basis()
    rotate_x(rotation_x)
    rotate_y(rotation_y)
    hidden_detector_camera.transform.basis = Basis()
    hidden_detector_camera.rotate_x(rotation_x)
    hidden_detector_camera.rotate_y(rotation_y)
    _check_crosshairs()    
    
func _check_crosshairs():
    var pixel_data = hidden_detector_viewport.get_texture().get_data()
    pixel_data.lock()
    object_in_sight_number = int(pixel_data.get_pixel(320, 240).a)
    get_tree().call_group("crosshairs", "in_sight", object_in_sight_number)
    pixel_data.unlock()

func _use():
    get_tree().call_group("area", "on_use", object_in_sight_number)
        
func _interact():
    get_tree().call_group("area", "on_interact", object_in_sight_number)

func has_flashlight():
    return $Flashlight.own_flashlight
