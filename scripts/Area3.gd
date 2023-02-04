extends Spatial

onready var object_1 = $Object1
onready var object_2 = $Object2
onready var object_3 = $Object3

func _ready():
    visible = false

func on_enter():
    _update_view_visibility()
    visible = true
    add_to_group("area")
    
func on_leave():
    visible = false
    remove_from_group("area")

func on_interact(object_number):
    match object_number:
        object_1.object_number:
            get_tree().call_group("subtitles", "show_subtitles", "the corridor goes a little bit back", 2)
            yield(get_tree().create_timer(3), "timeout")
        object_2.object_number:
            get_tree().call_group("subtitles", "show_subtitles", "a small nook under the staircase", 2)
            yield(get_tree().create_timer(3), "timeout")
        object_3.object_number:
            if not Global.door_3_open:
                get_tree().call_group("subtitles", "show_subtitles", "a door", 2)
            elif not Global.gate_3_open:
                get_tree().call_group("subtitles", "show_subtitles", "a gate", 2)
            else:
                get_tree().call_group("subtitles", "show_subtitles", "a passageway", 2)
            yield(get_tree().create_timer(3), "timeout")
    
func on_use(object_number):
    match object_number:
        object_1.object_number:
            get_tree().call_group("main", "switch_areas", "Area2")
        object_2.object_number:
            get_tree().call_group("main", "switch_areas", "Area4")
        object_3.object_number:
            if not Global.door_3_open:
                Global.door_3_open = true
                _update_view_visibility()
            elif not Global.gate_3_open:
                Global.gate_3_open = true
                _update_view_visibility()
            else:
                Global.reset_single_loop()
                get_tree().call_group("main", "switch_areas", "Area1")
            yield(get_tree().create_timer(3), "timeout")

func _update_view_visibility():
    $ViewLight.visible = Global.lights_on and not Global.door_3_open and not Global.gate_3_open
    $ViewLightDoor3Open.visible = Global.lights_on and Global.door_3_open and not Global.gate_3_open
    $ViewLightDoor3Gate3Open.visible = Global.lights_on and Global.door_3_open and Global.gate_3_open
    $ViewDark.visible = not Global.lights_on and not Global.door_3_open and not Global.gate_3_open
    $ViewDarkDoor3Open.visible = not Global.lights_on and Global.door_3_open and not Global.gate_3_open
    $ViewDarkDoor3Gate3Open.visible = not Global.lights_on and Global.door_3_open and Global.gate_3_open
