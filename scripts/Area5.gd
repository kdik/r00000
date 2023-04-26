extends Spatial

func _ready():
    visible = false

func on_enter(previous_area):
    _rotate_self_on_start(180)
    add_to_group("area")
    get_tree().call_group("player", "lock_actions")
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
    Global.ending = Global.WIN
    get_tree().call_group("main", "game_over")
    
func hide_all_views():
    $View1.visible = false
    $View2.visible = false
    $View3.visible = false
    $View4.visible = false
    $View5.visible = false
    
func on_leave(next_area):
    visible = false
    remove_from_group("area")

func on_interact(object_number):
    pass
    
func on_use(object_number):
    pass

func _rotate_self_on_start(rotation_deg):
    transform.basis = Basis()
    rotate_y(deg2rad(rotation_deg))
