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
    var description = ""
    match object_number:
        object_1.object_number: description = "the corridor goes a little bit back"
        object_2.object_number: description = "a small nook under the staircase"
        object_3.object_number:
            if not Global.door_3_open: description = "a door"
            elif not Global.gate_3_open: description = "a gate"
            else: description = "a passageway"
        object_4.object_number: description = "a battery powered light source"
    get_tree().call_group("player_subtitles", "show_subtitles", description)    
    
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
                get_tree().call_group("monster_eyes", "hide")
                get_tree().call_group("filter", "hide")
                yield(get_tree().create_timer(3), "timeout")
        object_4.object_number:
            if Global.batteries_removed:
                get_tree().call_group("player_subtitles", "show_subtitles", "I have no use for more batteries", 2)
                yield(get_tree().create_timer(3), "timeout")
            elif Global.batteries_removed:
                get_tree().call_group("player_subtitles", "show_subtitles", "the light source has no batteries", 2)
                yield(get_tree().create_timer(3), "timeout")
            else:
                Global.batteries_removed = true
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
                        get_tree().call_group("monster_eyes", "hide")
                        get_tree().call_group("filter", "hide")
                        Global.flashlight_on = true
                        _update_view_visibility()
                    yield(get_tree().create_timer(3), "timeout")
                else:
                    get_tree().call_group("player_subtitles", "show_subtitles", "I have no use for the battery I removed", 2)
                    yield(get_tree().create_timer(3), "timeout")
                yield(Global.monster_hide_and_seek_start("Area3"), "completed")
    yield(Global.monster_hide_and_seek("Area3"), "completed")
    if visible: get_tree().call_group("player", "unlock_actions")

func _update_view_visibility():
    $ViewLight.visible = Global.lights_on and not Global.door_3_open and not Global.gate_3_open
    $ViewLightDoor3Open.visible = Global.lights_on and Global.door_3_open and not Global.gate_3_open
    $ViewLightDoor3Gate3Open.visible = Global.lights_on and Global.door_3_open and Global.gate_3_open
    $ViewDark.visible = not Global.lights_on and not Global.door_3_open and not Global.gate_3_open
    $ViewDarkDoor3Open.visible = not Global.lights_on and Global.door_3_open
    $Graffiti.visible = Global.lights_on
    _update_object_visibility()

func _update_object_visibility():
    object_4.visible = Global.lights_on
    $Monster.visible = not Global.lights_on and not Global.flashlight_on and not Global.hide_and_seek_started

func _rotate_self_on_start(rotation_deg):
    transform.basis = Basis()
    rotate_y(deg2rad(rotation_deg))
