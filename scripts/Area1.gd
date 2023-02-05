extends Spatial

onready var object_1 = $Object1
onready var object_2 = $Object2
onready var object_3 = $Object3

func _ready():
    visible = false

func on_enter(previous_area):
    if previous_area == null: _rotate_self_on_start(-55)
    elif previous_area == "Area3": _rotate_self_on_start(-55)
    elif previous_area == "Area2": _rotate_self_on_start(120)
    _update_view_visibility()
    visible = true
    add_to_group("area")
    if Global.loops_completed > 0:
        get_tree().call_group("player", "lock_actions")
        yield(get_tree().create_timer(1), "timeout")
        var subtitle_text = ""
        match Global.loops_completed:
            1: subtitle_text = "this loops never ends"
            2: subtitle_text = "the roots are finally taking over"
            3: subtitle_text = "I feel worse every time"
            4: subtitle_text = "I am one with the roots, in my head"
            5: subtitle_text = "the horror, at last"
        get_tree().call_group("subtitles", "show_subtitles", subtitle_text, 3)
        yield(get_tree().create_timer(5), "timeout")
        get_tree().call_group("player", "unlock_actions")

func on_leave(next_area):
    visible = false
    remove_from_group("area")

func on_interact(object_number):
    match object_number:
        object_1.object_number:
            get_tree().call_group("subtitles", "show_subtitles", "no way I'm going down there", 2)
            yield(get_tree().create_timer(3), "timeout")
        object_2.object_number:
            get_tree().call_group("subtitles", "show_subtitles", "the door is locked", 2)
            yield(get_tree().create_timer(3), "timeout")
        object_3.object_number:
            get_tree().call_group("subtitles", "show_subtitles", "a light switch", 2)
            yield(get_tree().create_timer(3), "timeout")
    get_tree().call_group("player", "unlock_actions")
    
func on_use(object_number):
    match object_number:
        object_1.object_number:
            if Global.loops_completed == 5:
                Global.ending = Global.ROOTS
                get_tree().call_group("main", "game_over")
            else:
                get_tree().call_group("main", "switch_areas", "Area2")
                yield(get_tree().create_timer(3), "timeout")
        object_2.object_number:
            get_tree().call_group("subtitles", "show_subtitles", "the door is locked", 2)
            yield(get_tree().create_timer(3), "timeout")
        object_3.object_number:
            Global.lights_on = not Global.lights_on
            _update_view_visibility()
    get_tree().call_group("player", "unlock_actions")

func _update_view_visibility():
    $ViewLight.visible = Global.lights_on
    $ViewDark.visible = not Global.lights_on
    
func _rotate_self_on_start(rotation_deg):
    transform.basis = Basis()
    rotate_y(deg2rad(rotation_deg))
