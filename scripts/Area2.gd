extends Spatial

onready var object_1 = $Object1
onready var object_2 = $Object2
onready var object_3 = $Object3
onready var object_4 = $Object4

func _ready():
    visible = false

func on_enter(previous_area):
    if previous_area == "Area1": _rotate_self_on_start(0)
    if previous_area == "Area3": _rotate_self_on_start(170)
    _update_view_visibility()
    visible = true
    add_to_group("area")
    yield(Global.monster_introduction(), "completed")
    
func on_leave(next_area):
    visible = false
    remove_from_group("area")

func on_interact(object_number):
    match object_number:
        object_1.object_number:
            if Global.flashlight_on:
                get_tree().call_group("player_subtitles", "show_subtitles", "the light destroyed the parasite", 2)
                yield(get_tree().create_timer(3), "timeout")
            else:
                get_tree().call_group("player_subtitles", "show_subtitles", "an evil presence lurks there", 2)
                yield(get_tree().create_timer(3), "timeout")
        object_2.object_number:
            get_tree().call_group("player_subtitles", "show_subtitles", "a battery powered light source", 2)
            yield(get_tree().create_timer(3), "timeout")
        object_3.object_number:
            get_tree().call_group("player_subtitles", "show_subtitles", "the corridor goes a little bit further", 2)
            yield(get_tree().create_timer(3), "timeout")
        object_4.object_number:
            get_tree().call_group("player_subtitles", "show_subtitles", "upstairs, the door I came through", 2)
            yield(get_tree().create_timer(3), "timeout")
    get_tree().call_group("player", "unlock_actions")
    
func on_use(object_number):
    match object_number:
        object_1.object_number:
            Global.lights_on = false
            _update_view_visibility()
            if Global.flashlight_on:
                Global.ending = Global.WIN
                get_tree().call_group("main", "game_over")
        object_2.object_number:
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
                    Global.flashlight_on = true
                    _update_view_visibility()
                yield(get_tree().create_timer(3), "timeout")
            else:
                get_tree().call_group("player_subtitles", "show_subtitles", "I have no use for the battery I removed", 2)
                yield(get_tree().create_timer(3), "timeout")
        object_3.object_number:
            get_tree().call_group("main", "switch_areas", "Area3")
            yield(get_tree().create_timer(3), "timeout")
        object_4.object_number:
            get_tree().call_group("main", "switch_areas", "Area1")
            yield(get_tree().create_timer(3), "timeout")
    yield(Global.monster_hide_and_seek(), "completed")
    if visible: get_tree().call_group("player", "unlock_actions")

func _update_view_visibility():
    $ViewLight.visible = Global.lights_on and not Global.door_3_open and not Global.gate_3_open
    $ViewLightDoor3Open.visible = Global.lights_on and Global.door_3_open and not Global.gate_3_open
    $ViewLightDoor3Gate3Open.visible = Global.lights_on and Global.door_3_open and Global.gate_3_open
    $ViewDark.visible = not Global.lights_on and not Global.door_3_open
    $ViewDarkDoor3Open.visible = not Global.lights_on and Global.door_3_open
    _update_object_visibility()
    
func _update_object_visibility():
    object_2.visible = Global.lights_on
    $Monster.visible = not Global.lights_on and not Global.flashlight_on

func _rotate_self_on_start(rotation_deg):
    transform.basis = Basis()
    rotate_y(deg2rad(rotation_deg))
