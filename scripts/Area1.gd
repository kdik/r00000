extends R00000Area

onready var object_1 = $Object1
onready var object_2 = $Object2
onready var object_3 = $Object3

func get_initial_rotation(previous_area):
    if previous_area == null: return -55
    elif previous_area == "Area3": return -55
    elif previous_area == "Area2": return 120
    else: return 0

func init(previous_area):
    if Global.loops_completed > 0 and previous_area != "Area2":
        yield(get_tree().create_timer(1), "timeout")
        var subtitle_text = ""
        match Global.loops_completed:
            1: subtitle_text = "this loop never ends"
            2: subtitle_text = "the roots are finally taking over"
            3: subtitle_text = "I feel worse every time"
            4: subtitle_text = "I am one with the roots, in my head"
            5: subtitle_text = "the horror, at last"
        get_tree().call_group("player_subtitles", "show_subtitles", subtitle_text, 3)
        yield(get_tree().create_timer(4), "timeout")

func get_description(object_number):
    match object_number:
        object_1.object_number: return "no way I'm going down there"
        object_2.object_number:
            if Global.flashlight_on and not Global.lights_on: return "the door is not locked"
            else: return "the door is locked"
        object_3.object_number: return "a light switch"

func trigger_use(object_number):
    match object_number:
        object_1.object_number:
            if Global.loops_completed == 5:
                Global.ending = Global.ROOTS
                get_tree().call_group("main", "game_over")
            else:
                get_tree().call_group("main", "switch_areas", "Area2")
                yield(get_tree().create_timer(3), "timeout")
        object_2.object_number:
            if Global.flashlight_on and not Global.lights_on:
                $Snow.visible = true
                $ViewDarkEscape.visible = true
                get_tree().call_group("player", "lock_actions")
                get_tree().call_group("player", "lock_movement")
                yield(get_tree().create_timer(5), "timeout")
                get_tree().call_group("player", "turn_off_flashlight")
                yield(get_tree().create_timer(2), "timeout")
                Global.ending = Global.ESCAPE
                get_tree().call_group("main", "game_over")
            else:
                get_tree().call_group("player_subtitles", "show_subtitles", "the door is locked", 2)
                yield(get_tree().create_timer(3), "timeout")
        object_3.object_number:
            if Global.batteries_removed:
                get_tree().call_group("player_subtitles", "show_subtitles", "it did not work", 2)
                yield(get_tree().create_timer(3), "timeout")
            else:
                Global.lights_on = not Global.lights_on
                if Global.lights_on:
                    Global.actions_in_darkness = 0
                    Global.hide_and_seek_started = false
                    get_tree().call_group("monster_eyes", "hide")
                update_visibilities()
    yield(Global.monster_hide_and_seek("Area1"), "completed")
    if visible: get_tree().call_group("player", "unlock_actions")

func update_visibilities():
    $ViewLight.visible = Global.lights_on
    $ViewDark.visible = not Global.lights_on
    $Snow.visible = false
    $ViewDarkEscape.visible = false
