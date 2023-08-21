extends R00000Area

func play_fade_in(next_area):
    return false

func get_initial_rotation(previous_area):
    return 180

func init(previous_area):
    yield(say_yourself(YouScreen.I_CAN_STILL_HEAR), "completed")
    get_tree().call_group("player", "lock_movement")
    show_view($View1)
    visible = true
    yield(get_tree().create_timer(1), "timeout")
    get_tree().call_group("player_automated_movement", "turn", -0.1309, -2.356194)
    yield(get_tree().create_timer(1), "timeout")
    show_view($View2)
    yield(get_tree().create_timer(0.15), "timeout")
    show_view($View3)
    yield(get_tree().create_timer(0.15), "timeout")
    show_view($View4)
    yield(get_tree().create_timer(0.15), "timeout")
    show_view($View5)
    yield(get_tree().create_timer(2), "timeout")
    get_tree().call_group("player", "turn_off_flashlight")
    yield(get_tree().create_timer(1), "timeout")
    get_tree().call_group("main", "game_over", Global.BECOME_EVIL)

func show_view(view):
    view.set_visibility(true)
