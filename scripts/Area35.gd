extends R00000Area

func get_initial_rotation(previous_area):
    return 180

func init(previous_area):
    get_tree().call_group("player", "lock_movement")
    hide_all_views()
    $View1.visible = true
    visible = true
    yield(get_tree().create_timer(1), "timeout")
    get_tree().call_group("player_automated_movement", "turn", -0.1309, -2.356194)
    yield(get_tree().create_timer(1), "timeout")
    hide_all_views()
    $View2.visible = true
    yield(get_tree().create_timer(0.15), "timeout")
    hide_all_views()
    $View3.visible = true
    yield(get_tree().create_timer(0.15), "timeout")
    hide_all_views()    
    $View4.visible = true
    yield(get_tree().create_timer(0.15), "timeout")
    hide_all_views()
    $View5.visible = true
    yield(get_tree().create_timer(2), "timeout")
    get_tree().call_group("player", "turn_off_flashlight")
    yield(get_tree().create_timer(1), "timeout")
    get_tree().call_group("main", "game_over", Global.BECOME_EVIL)
    
func hide_all_views():
    $View1.visible = false
    $View2.visible = false
    $View3.visible = false
    $View4.visible = false
    $View5.visible = false
