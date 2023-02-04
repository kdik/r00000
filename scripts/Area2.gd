extends Spatial

onready var object_1 = $Object1
onready var object_2 = $Object2
onready var object_3 = $Object3
onready var object_4 = $Object4

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
            get_tree().call_group("subtitles", "show_subtitles", "an evil presence awaits", 2)
            yield(get_tree().create_timer(3), "timeout")
        object_2.object_number:
            get_tree().call_group("subtitles", "show_subtitles", "a battery powered light source", 2)
            yield(get_tree().create_timer(3), "timeout")
        object_3.object_number:
            get_tree().call_group("subtitles", "show_subtitles", "the corridor goes a little bit further", 2)
            yield(get_tree().create_timer(3), "timeout")
        object_4.object_number:
            get_tree().call_group("subtitles", "show_subtitles", "upstairs, the door I came through", 2)
            yield(get_tree().create_timer(3), "timeout")
    
func on_use(object_number):
    match object_number:
        object_1.object_number:
            Global.lights_on = false
            _update_view_visibility()
            get_tree().call_group("subtitles", "show_subtitles", "the evil is unleashed", 2)
            yield(get_tree().create_timer(3), "timeout")
            Global.ending = Global.EVIL
            get_tree().call_group("main", "game_over")
        object_2.object_number:
            Global.lights_on = false
            _update_view_visibility()
            if not Global.have_flashlight:
                get_tree().call_group("subtitles", "show_subtitles", "I have no use for the battery I removed", 2)
                yield(get_tree().create_timer(3), "timeout")
        object_3.object_number:
            get_tree().call_group("main", "switch_areas", "Area3")
        object_4.object_number:
            get_tree().call_group("main", "switch_areas", "Area1")

func _update_view_visibility():
    $ViewLight.visible = Global.lights_on
    $ViewDark.visible = not Global.lights_on
    _update_object_visibility()
    
func _update_object_visibility():
    object_2.visible = Global.lights_on
