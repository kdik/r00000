extends Node

func introduce(eye_coordinates, fade_out_function_name):
    if Global.hide_and_seek_started or Global.monster_defeated:
        return yield(get_tree(), "idle_frame")
    Global.door_2_open = true
    get_tree().call_group("rumble", "play")
    get_tree().call_group("area", "update_visibilities")
    get_tree().call_group("player", "lock_movement")
    yield(get_tree().create_timer(1.5), "timeout")
    get_tree().call_group("player_automated_movement", "turn", eye_coordinates.x, eye_coordinates.y)
    yield(get_tree().create_timer(2.5), "timeout")
    get_tree().call_group("monster_screen", "start_showing", MonsterScreen.IS_THIS_GOOD_ENOUGH)
    yield(get_tree().create_timer(3), "timeout")
    get_tree().call_group("rumble", "play_intro_sequence")
    get_tree().call_group("monster_eyes", fade_out_function_name)
    yield(get_tree().create_timer(1.5), "timeout")
    get_tree().call_group("filter", "start_playing")
    get_tree().call_group("filter", "set_alpha", 0.05)
    get_tree().call_group("monster_view", "stop_showing")
    Global.hide_and_seek_started = true
    Global.door_2_open = false
    get_tree().call_group("area", "update_visibilities")
    get_tree().call_group("monster_eyes", "fade_in")
    yield(get_tree().create_timer(3), "timeout")
    get_tree().call_group("player", "unlock_movement")

func on_use():
    if not Global.hide_and_seek_started or Global.monster_defeated or Global.lights_on:
        return yield(get_tree(), "idle_frame")
    var alpha = 0.0
    match int(Global.actions_in_darkness):
        1: alpha = 0.05
        2: alpha = 0.1
        3: alpha = 0.2
        4: alpha = 0.3
    get_tree().call_group("filter", "start_playing")
    get_tree().call_group("filter", "set_alpha", alpha)
    get_tree().call_group("rumble", "play")
    if Global.actions_in_darkness > 3:
        Global.hide_and_seek_lost = true
        yield(get_tree().create_timer(3), "timeout")
        get_tree().call_group("main", "game_over", Global.CAUGHT)
        get_tree().call_group("rumble", "stop")
    else:
        yield(get_tree(), "idle_frame")
        
func on_load():
    if not Global.hide_and_seek_started or Global.monster_defeated or Global.lights_on:
        return
    var alpha = 0.0
    match int(Global.actions_in_darkness):
        1: alpha = 0.05
        2: alpha = 0.1
        3: alpha = 0.2
        4: alpha = 0.3
    get_tree().call_group("filter", "start_playing")
    get_tree().call_group("filter", "set_alpha", alpha)
    get_tree().call_group("monster_eyes", "fade_in")
    get_tree().call_group("rumble", "play_load_sequence")

func illuminate():
    Global.actions_in_darkness = 0
    Global.hide_and_seek_started = false
    get_tree().call_group("monster_eyes", "stop_showing")
