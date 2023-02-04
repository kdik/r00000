extends Camera

var rotation_speed = PI / 48
var rotation_x = 0
var rotation_y = 0
onready var hidden_detector_viewport = $HiddenDetectorViewport
onready var hidden_detector_camera = $HiddenDetectorViewport/HiddenDetectorCamera

func _ready():
    _update_cursor()

func _process(_delta):
    if Input.is_action_just_pressed("ui_cancel"):
        get_tree().quit()
    elif Input.is_action_pressed("ui_left"):
        rotation_y += rotation_speed
        _update_rotation()
        _update_cursor()
    elif Input.is_action_pressed("ui_right"):
        rotation_y -= rotation_speed
        _update_rotation()
        _update_cursor()
    elif Input.is_action_pressed("ui_up"):
        rotation_x += rotation_speed
        _update_rotation()
        _update_cursor()
    elif Input.is_action_pressed("ui_down"):
        rotation_x -= rotation_speed
        _update_rotation()    
        _update_cursor()
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
    
func _update_cursor():
    var pixel_data = hidden_detector_viewport.get_texture().get_data()
    pixel_data.lock()
    if pixel_data.get_pixel(320, 240).a > 0:
        $CursorActive.visible = true
        $CursorInactive.visible = false
    else:
        $CursorActive.visible = false
        $CursorInactive.visible = true
    pixel_data.unlock()

func _use():
    if $CursorActive.visible:
        get_tree().call_group("audio", "play", "Footsteps")
        get_tree().call_group("ui", "fade_out_fade_in")
        yield(get_tree().create_timer(2), "timeout")
        
func _interact():
    if $CursorActive.visible:
        get_tree().call_group("subtitles", "show_subtitles", "no way I'm going down there", 3)
        yield(get_tree().create_timer(3), "timeout")
