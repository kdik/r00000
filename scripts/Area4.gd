extends Spatial

onready var object_1 = $Object1
onready var object_2 = $Object2

func _ready():
    visible = false

func on_enter(previous_area):
    _rotate_self_on_start(30)
    _update_view_visibility()
    visible = true
    add_to_group("area")
    
func on_leave(next_area):
    visible = false
    remove_from_group("area")

func on_interact(object_number):
    var description = ""
    match object_number:
        object_1.object_number: description = "the corridor does not seem as cramped"
        object_2.object_number: description = "a flashlight without batteries"
    get_tree().call_group("player_subtitles", "show_subtitles", description)
    
func on_use(object_number):
    match object_number:
        object_1.object_number:
            get_tree().call_group("main", "switch_areas", "Area3")
            yield(get_tree().create_timer(3), "timeout")
        object_2.object_number:
            Global.have_flashlight = true
            _update_view_visibility()
            get_tree().call_group("player", "acquire_flashlight")
            get_tree().call_group("player_subtitles", "show_subtitles", "now I only need batteries", 2)
            yield(get_tree().create_timer(3), "timeout")
    yield(Global.monster_hide_and_seek("Area4"), "completed")
    if visible: get_tree().call_group("player", "unlock_actions")
    
func _update_view_visibility():
    $ViewLight.visible = Global.lights_on and Global.have_flashlight and not Global.door_3_open
    $ViewLightFlashlight.visible = Global.lights_on and not Global.have_flashlight and not Global.door_3_open
    $ViewLightDoor3Open.visible = Global.lights_on and Global.have_flashlight and Global.door_3_open
    $ViewLightFlashlightDoor3Open.visible = Global.lights_on and not Global.have_flashlight and Global.door_3_open
    $ViewDark.visible = not Global.lights_on and not Global.door_3_open
    $ViewDarkDoor3Open.visible = not Global.lights_on and Global.door_3_open
    $Graffiti.visible = Global.lights_on
    _update_object_visibility()
    
func _update_object_visibility():
    $Object2.visible = not Global.have_flashlight

func _rotate_self_on_start(rotation_deg):
    transform.basis = Basis()
    rotate_y(deg2rad(rotation_deg))
