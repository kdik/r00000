extends Spatial

onready var object_1 = $Object1
onready var object_2 = $Object2
onready var object_3 = $Object3
onready var object_4 = $Object4

func _ready():
    visible = false

func on_enter(previous_area):
    if previous_area == "Area2": _rotate_self_on_start(135)
    if previous_area == "Area4": _rotate_self_on_start(0)
    _update_view_visibility()
    visible = true
    add_to_group("area")
    
func on_leave(next_area):
    visible = false
    remove_from_group("area")

func on_interact(object_number):
    match object_number:
        object_1.object_number:
            get_tree().call_group("player_subtitles", "show_subtitles", "the corridor goes a little bit back", 2)
            yield(get_tree().create_timer(3), "timeout")
        object_2.object_number:
            get_tree().call_group("player_subtitles", "show_subtitles", "a small nook under the staircase", 2)
            yield(get_tree().create_timer(3), "timeout")
        object_3.object_number:
            if not Global.door_3_open:
                get_tree().call_group("player_subtitles", "show_subtitles", "a door", 2)
            elif not Global.gate_3_open:
                get_tree().call_group("player_subtitles", "show_subtitles", "a gate", 2)
            else:
                get_tree().call_group("player_subtitles", "show_subtitles", "a passageway", 2)
            yield(get_tree().create_timer(3), "timeout")
        object_4.object_number:
            get_tree().call_group("player_subtitles", "show_subtitles", "a battery powered light source", 2)
            yield(get_tree().create_timer(3), "timeout")
    get_tree().call_group("player", "unlock_actions")
    
func on_use(object_number):
    match object_number:
        object_1.object_number:
            get_tree().call_group("main", "switch_areas", "Area2")
            yield(get_tree().create_timer(3), "timeout")
        object_2.object_number:
            get_tree().call_group("main", "switch_areas", "Area4")
            yield(get_tree().create_timer(3), "timeout")
        object_3.object_number:
            if not Global.door_3_open:
                Global.door_3_open = true
                _update_view_visibility()
            elif not Global.gate_3_open:
                Global.gate_3_open = true
                _update_view_visibility()
            else:
                Global.loops_completed += 1
                Global.reset_single_loop()
                get_tree().call_group("main", "switch_areas", "Area1")
                yield(get_tree().create_timer(3), "timeout")
        object_4.object_number:
            Global.lights_on = false
            _update_view_visibility()
            if Global.have_flashlight and Global.battery_count < 3:
                get_tree().call_group("player", "add_battery")
                yield(get_tree().create_timer(3), "timeout")
                if Global.battery_count == 1:
                    get_tree().call_group("player_subtitles", "show_subtitles", "two more batteries left to go", 2)
                elif Global.battery_count == 2:
                    get_tree().call_group("player_subtitles", "show_subtitles", "one more battery left to go", 2)
                elif Global.battery_count == 3:
                    get_tree().call_group("player_subtitles", "show_subtitles", "bingo", 2)
                    get_tree().call_group("player", "turn_on_flashlight")
                yield(get_tree().create_timer(3), "timeout")
            else:
                get_tree().call_group("player_subtitles", "show_subtitles", "I have no use for the battery I removed", 2)
                yield(get_tree().create_timer(3), "timeout")
    yield(Global.monster_hide_and_seek(), "completed")
    if visible: get_tree().call_group("player", "unlock_actions")

func _update_view_visibility():
    $ViewLight.visible = Global.lights_on and not Global.door_3_open and not Global.gate_3_open
    $ViewLightDoor3Open.visible = Global.lights_on and Global.door_3_open and not Global.gate_3_open
    $ViewLightDoor3Gate3Open.visible = Global.lights_on and Global.door_3_open and Global.gate_3_open
    $ViewDark.visible = not Global.lights_on and not Global.door_3_open and not Global.gate_3_open
    $ViewDarkDoor3Open.visible = not Global.lights_on and Global.door_3_open
    _update_object_visibility()

func _update_object_visibility():
    object_4.visible = Global.lights_on
    $Monster.visible = not Global.lights_on and not Global.flashlight_on

func _rotate_self_on_start(rotation_deg):
    transform.basis = Basis()
    rotate_y(deg2rad(rotation_deg))
