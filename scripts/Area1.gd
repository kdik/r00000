extends R00000Area

onready var object_1 = $Object1
onready var object_2 = $Object2
onready var object_3 = $Object3

func play_fade_in(previous_area):
    return previous_area != null and previous_area != "Area3"

func play_fade_out(next_area):
    return next_area != "Area2" or Global.monster_introduced or not Global.lights_on

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
    else: yield(get_tree(), "idle_frame")

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
                get_tree().call_group("main", "game_over", Global.ROOTS)
            else:
                get_tree().call_group("main", "switch_areas", "Area2")
        object_2.object_number:
            if Global.flashlight_on and not Global.lights_on:
                yield(_init_escape_ending(), "completed")
            else:
                yield(say("the door does not budge"), "completed")
        object_3.object_number:
            if Global.batteries_removed:
                yield(say("it did not work"), "completed")
            else:
                Global.lights_on = not Global.lights_on
                if Global.lights_on: Monster.illuminate()
                update_visibilities()
    yield(get_tree(), "idle_frame")

func update_visibilities():
    $ViewLight.visible = Global.lights_on
    $ViewDark.visible = not Global.lights_on
    $Snow.visible = false
    $ViewDarkEscape.visible = false

func _init_escape_ending():
    $Snow.visible = true
    $ViewDarkEscape.visible = true
    get_tree().call_group("player", "lock_movement")
    yield(get_tree().create_timer(5), "timeout")
    get_tree().call_group("player", "turn_off_flashlight")
    yield(get_tree().create_timer(2), "timeout")
    get_tree().call_group("main", "game_over", Global.ESCAPE)
