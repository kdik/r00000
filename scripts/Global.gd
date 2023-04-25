extends Node

# persistent between loops variables
var have_flashlight = false
var battery_count = 0
var loops_completed = 0
var flashlight_on = false
var ending

# non persistent between loops variables
var lights_on = true
var actions_in_darkness = 0
var door_3_open = false
var gate_3_open = false
var batteries_removed = false
var monster_introduced = false
var hide_and_seek_started = false
var hide_and_seek_lost = false

enum {ROOTS, EVIL, WIN}

func reset():
    have_flashlight = false
    battery_count = 0
    loops_completed = 0
    flashlight_on = false
    reset_single_loop()
    
func reset_single_loop():
    lights_on = true
    actions_in_darkness = 0
    door_3_open = false
    gate_3_open = false
    batteries_removed = false
    monster_introduced = false
    hide_and_seek_started = false
    hide_and_seek_lost = false
    
func monster_introduction():
    if not Global.lights_on or Global.flashlight_on:
        return yield(get_tree(), "idle_frame")
    if monster_introduced:
        return yield(get_tree(), "idle_frame")
    monster_introduced = true
    get_tree().call_group("player", "lock_actions")
    yield(get_tree().create_timer(1.5), "timeout")
    get_tree().call_group("monster_subtitles", "show_subtitles", "it's me, behind the door", 3)
    yield(get_tree().create_timer(4), "timeout")
    get_tree().call_group("monster_subtitles", "show_subtitles", "let me out", 3)
    yield(get_tree().create_timer(4), "timeout")
    get_tree().call_group("player", "unlock_actions")
    
func monster_hide_and_seek_start(area):
    if hide_and_seek_started or Global.lights_on or Global.flashlight_on:
        return yield(get_tree(), "idle_frame")
    get_tree().call_group("player", "lock_actions")
    get_tree().call_group("player", "lock_movement")
    yield(get_tree().create_timer(1.5), "timeout")
    if area == "Area2":
        get_tree().call_group("player_automated_movement", "turn", -0.19635, -2.159845)
    elif area == "Area3":
        get_tree().call_group("player_automated_movement", "turn", -0.1309, 2.552544)
    yield(get_tree().create_timer(2), "timeout")  
    get_tree().call_group("monster_subtitles", "show_subtitles", "hello, my friend", 4)
    get_tree().call_group("filter", "play")
    get_tree().call_group("filter", "set_alpha", 0.05)
    yield(get_tree().create_timer(6), "timeout")
    get_tree().call_group("monster_subtitles", "show_subtitles", "You get a few moves before I hurt you", 5)
    yield(get_tree().create_timer(7), "timeout")
    if area == "Area2":
        get_tree().call_group("monster_eyes", "fade_out_near")
    elif area == "Area3":
        get_tree().call_group("monster_eyes", "fade_out_far")
    yield(get_tree().create_timer(1.5), "timeout")
    get_tree().call_group("monster", "hide")
    get_tree().call_group("monster_eyes", "fade_in")
    yield(get_tree().create_timer(3), "timeout")
    get_tree().call_group("player", "unlock_actions")
    get_tree().call_group("player", "unlock_movement")
    hide_and_seek_started = true

func monster_hide_and_seek(area):
    if not hide_and_seek_started or Global.lights_on or Global.flashlight_on:
        return yield(get_tree(), "idle_frame")
    get_tree().call_group("player", "lock_actions")
    yield(get_tree().create_timer(1.5), "timeout")
    match Global.actions_in_darkness:
        1:
            get_tree().call_group("monster_subtitles", "show_subtitles", "three", 3)
            get_tree().call_group("filter", "play")
            get_tree().call_group("filter", "set_alpha", 0.1)
            yield(get_tree().create_timer(4), "timeout")
        2:
            get_tree().call_group("monster_subtitles", "show_subtitles", "two", 3)
            get_tree().call_group("filter", "play")
            get_tree().call_group("filter", "set_alpha", 0.2)
            yield(get_tree().create_timer(4), "timeout")
        3:
            get_tree().call_group("monster_subtitles", "show_subtitles", "one", 3)
            get_tree().call_group("filter", "play")
            get_tree().call_group("filter", "set_alpha", 0.3)
            yield(get_tree().create_timer(5), "timeout")
            get_tree().call_group("monster_subtitles", "show_subtitles", "here I come", 5)
            yield(get_tree().create_timer(5), "timeout")
            hide_and_seek_lost = true
            yield(get_tree().create_timer(3), "timeout")
            Global.ending = Global.EVIL
            get_tree().call_group("main", "game_over")
    get_tree().call_group("player", "unlock_actions")

