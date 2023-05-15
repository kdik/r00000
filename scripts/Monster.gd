extends Node

func introduce(eye_coordinates, fade_out_function_name):
    if Global.hide_and_seek_started or Global.lights_on or Global.flashlight_on or Global.monster_defeated:
        return yield(get_tree(), "idle_frame")
    get_tree().call_group("player", "lock_movement")
    yield(get_tree().create_timer(1.5), "timeout")
    get_tree().call_group("player_automated_movement", "turn", eye_coordinates.x, eye_coordinates.y)
    yield(get_tree().create_timer(2), "timeout")  
    get_tree().call_group("monster_eyes", fade_out_function_name)
    yield(get_tree().create_timer(1.5), "timeout")
    get_tree().call_group("filter", "play")
    get_tree().call_group("filter", "set_alpha", 0.05)
    get_tree().call_group("monster_view", "hide")
    get_tree().call_group("monster_eyes", "fade_in")
    yield(get_tree().create_timer(3), "timeout")
    get_tree().call_group("player", "unlock_movement")
    Global.hide_and_seek_started = true

func on_use():
    if not Global.hide_and_seek_started or Global.monster_defeated or Global.lights_on:
        return yield(get_tree(), "idle_frame")
    var alpha = 0.0
    match Global.actions_in_darkness:
        1: alpha = 0.1
        2: alpha = 0.2
        3: alpha = 0.3
    get_tree().call_group("filter", "play")
    get_tree().call_group("filter", "set_alpha", alpha)
    if Global.actions_in_darkness > 3:
        Global.hide_and_seek_lost = true
        yield(get_tree().create_timer(3), "timeout")
        get_tree().call_group("main", "game_over", Global.CAUGHT)
    else:
        yield(get_tree(), "idle_frame")

func illuminate():
    Global.actions_in_darkness = 0
    Global.hide_and_seek_started = false
    get_tree().call_group("monster_eyes", "hide")
