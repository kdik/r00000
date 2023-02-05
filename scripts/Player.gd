extends Camera

var rotation_speed = PI / 48
var rotation_x = 0
var rotation_y = 0
var object_in_sight_number = 0
var actions_locked = false
onready var hidden_detector_viewport = $HiddenDetectorViewport
onready var hidden_detector_camera = $HiddenDetectorViewport/HiddenDetectorCamera

func _ready():
    add_to_group("player")

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
        
func acquire_flashlight():
    Global.have_flashlight = true
    $Cursor/RightHand.set_frame(45)
    $Cursor/RightHand.visible = true

func add_battery():
    Global.battery_count += 1
    $Cursor/LeftHand.visible = false
    $Cursor/RightHand.set_frame(0)
    $Cursor/RightHand.visible = true
    $Cursor/RightHand.play()
    yield(get_tree().create_timer(3), "timeout")
    $Cursor/LeftHand.visible = true
    
func turn_on_flashlight():
    $Flashlight.visible = true
    Global.flashlight_on = true
    
func turn_off_flashlight():
    $Flashlight.visible = false
    
func lock_actions():
    $Cursor/Target.visible = false
    actions_locked = true
    
func unlock_actions():
    $Cursor/Target.visible = true
    actions_locked = false    
    
func reset_object_in_sight():
    _check_crosshairs()
    
func reset_position():
    rotation_x = 0
    rotation_y = 0
    _update_rotation()
    
func _use():
    if actions_locked:
        return
    lock_actions()
    if not Global.lights_on: Global.actions_in_darkness += 1
    get_tree().call_group("area", "on_use", object_in_sight_number)
        
func _interact():
    if actions_locked:
        return
    lock_actions()
    get_tree().call_group("area", "on_interact", object_in_sight_number)

func has_flashlight():
    return $Flashlight.own_flashlight
