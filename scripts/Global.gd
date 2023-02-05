extends Node

# persistent between loops variables
var have_flashlight = false
var battery_count = 0
var loops_completed = 0
var ending

# non persistent between loops variables 
var lights_on = true
var actions_in_darkness = 0
var door_3_open = false
var gate_3_open = false
var flashlight_on = false

enum {ROOTS, EVIL, WIN}

func reset():
    have_flashlight = false
    battery_count = 0
    loops_completed = 0
    reset_single_loop()
    
func reset_single_loop():
    lights_on = true
    actions_in_darkness = 0
    door_3_open = false
    gate_3_open = false
    flashlight_on = false
    
func monster_introduction():
    get_tree().call_group("monster_subtitles", "show_subtitles", "it's me, behind the door", 3)
    yield(get_tree().create_timer(4), "timeout")
    get_tree().call_group("monster_subtitles", "show_subtitles", "let me out", 3)
    yield(get_tree().create_timer(4), "timeout")
    
func monster_hide_and_seek():
    if Global.lights_on:
        return yield(get_tree(), "idle_frame")
    match Global.actions_in_darkness:
        0:
            get_tree().call_group("monster_subtitles", "show_subtitles", "hello, my friend", 4)
            yield(get_tree().create_timer(6), "timeout")
            get_tree().call_group("monster_subtitles", "show_subtitles", "I will give you a few moves before I hurt you", 5)
            yield(get_tree().create_timer(7), "timeout")
        1:
            get_tree().call_group("monster_subtitles", "show_subtitles", "three", 3)
            yield(get_tree().create_timer(4), "timeout")
        2:
            get_tree().call_group("monster_subtitles", "show_subtitles", "two", 3)
            yield(get_tree().create_timer(4), "timeout")
        3:
            get_tree().call_group("monster_subtitles", "show_subtitles", "one", 3)
            yield(get_tree().create_timer(5), "timeout")
            get_tree().call_group("monster_subtitles", "show_subtitles", "here I come", 5)
            yield(get_tree().create_timer(7), "timeout")
            Global.ending = Global.EVIL
            get_tree().call_group("main", "game_over")

