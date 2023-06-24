extends Camera

var rotation_speed = PI / 48
var rotation_x = 0
var rotation_y = 0
var object_in_sight_number = 0
var actions_locked = false
var movement_locked = false
onready var hidden_detector_viewport = $HiddenDetectorViewport
onready var hidden_detector_camera = $HiddenDetectorViewport/HiddenDetectorCamera

func _ready():
    add_to_group("player")

func _process(_delta):
    if Input.is_action_just_pressed("ui_select") or Input.is_action_just_pressed("ui_accept"):
        _use()
        return
    if movement_locked:
        return
    elif Input.is_action_pressed("ui_left"):
        set_rotation_y(rotation_y + rotation_speed)
        update_rotation()
        check_crosshairs()
    elif Input.is_action_pressed("ui_right"):
        set_rotation_y(rotation_y - rotation_speed)
        update_rotation()
        check_crosshairs()
    elif Input.is_action_pressed("ui_up"):
        set_rotation_x(rotation_x + rotation_speed)
        update_rotation()
        check_crosshairs()
    elif Input.is_action_pressed("ui_down"):
        set_rotation_x(rotation_x - rotation_speed)
        update_rotation()
        check_crosshairs()    

func _calculate_rotation(start, increment):
    var sum = start + increment
    if sum > PI: return sum - 2.0 * PI
    elif sum < - PI: return sum + 2.0 * PI
    else: return sum
    
func set_rotation_x(x):
    if x > PI: rotation_x = x - 2.0 * PI
    elif x < - PI: rotation_x = x + 2.0 * PI
    else: rotation_x = x
    
func set_rotation_y(y):
    if y > PI: rotation_y = y - 2.0 * PI
    elif y < - PI: rotation_y = y + 2.0 * PI
    else: rotation_y = y

func update_rotation():
    #print("rot_x: " + str(rotation_x) + " rot_y: " + str(rotation_y))
    rotation_x = clamp(rotation_x, -0.25 * PI, 0.25 * PI)
    transform.basis = Basis()
    rotate_x(rotation_x)
    rotate_y(rotation_y)
    hidden_detector_camera.transform.basis = Basis()
    hidden_detector_camera.rotate_x(rotation_x)
    hidden_detector_camera.rotate_y(rotation_y)
    
func check_crosshairs():
    var pixel_data = hidden_detector_viewport.get_texture().get_data()
    pixel_data.lock()
    var previous_object_in_sight_number = object_in_sight_number
    var current_object_in_sight_number = int(pixel_data.get_pixel(320, 240).a)
    object_in_sight_number = current_object_in_sight_number
    pixel_data.unlock()  
    if not actions_locked: 
        _update_hand_position(previous_object_in_sight_number, current_object_in_sight_number)
        _update_subtitles(previous_object_in_sight_number, current_object_in_sight_number)
    
func _update_hand_position(previous_object_number, current_object_number):
    if current_object_number > 0:
        get_tree().call_group("left_hand", "open")
    elif current_object_number == 0:
        get_tree().call_group("left_hand", "close")
        
func _update_subtitles(previous_object_number, current_object_number):
    if previous_object_number == 0 and current_object_number > 0:
        get_tree().call_group("area", "on_interact", current_object_number)
    elif previous_object_number != 0 and current_object_number == 0:
        get_tree().call_group("player_subtitles", "fade_out")

func acquire_flashlight():
    Global.have_flashlight = true
    $Cursor/RightHand.set_frame(45)
    $Cursor/RightHand.visible = true
    get_tree().call_group("battery_indicator", "update_battery_count")

func add_battery():
    Global.battery_count += 1
    $Cursor/LeftHand.visible = false
    $Cursor/RightHand.set_frame(0)
    $Cursor/RightHand.visible = true
    $Cursor/RightHand.play()
    yield(get_tree().create_timer(3), "timeout")
    $Cursor/LeftHand.visible = true
    get_tree().call_group("battery_indicator", "update_battery_count")
    
func turn_on_flashlight():
    $Flashlight.visible = true
    Global.flashlight_on = true
    
func turn_off_flashlight():
    $Flashlight.visible = false
    
func show_middle_finger():
    $Cursor/LeftHand.visible = false
    $Cursor/MiddleFinger.set_frame(0)
    $Cursor/MiddleFinger.visible = true
    $Cursor/MiddleFinger.play()
    yield(get_tree().create_timer(38.0 / 15.0), "timeout")
    $Cursor/MiddleFinger.visible = false
    $Cursor/LeftHand.visible = true

func lock_actions():
    print("Player actions locked")
    if actions_locked: return
    actions_locked = true
    if object_in_sight_number > 0:
        var previous_object_in_sight_number = object_in_sight_number
        var current_object_in_sight_number = 0
        object_in_sight_number = current_object_in_sight_number
        _update_hand_position(previous_object_in_sight_number, current_object_in_sight_number)
        _update_subtitles(previous_object_in_sight_number, current_object_in_sight_number)
    
func unlock_actions():
    print("Player actions unlocked")
    if not actions_locked: return
    actions_locked = false
    check_crosshairs()

func lock_movement():
    print("Player movement locked")
    movement_locked = true
    $Cursor/Target.visible = false
    
func unlock_movement():
    print("Player movement unlocked")
    movement_locked = false
    $Cursor/Target.visible = true
    
func reset_position():
    rotation_x = 0
    rotation_y = 0
    update_rotation()
    
func _use():
    if actions_locked:
        return
    get_tree().call_group("area", "on_use", object_in_sight_number)

func has_flashlight():
    return $Flashlight.own_flashlight
