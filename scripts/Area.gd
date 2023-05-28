class_name R00000Area
extends Spatial

func _ready():
    visible = false

# functions overriden by extended class
# -------------------------------------
func update_visibilities():
    pass
    
func init(previous_area):
    yield(get_tree(), "idle_frame")

func get_description(object_number):
    return ""
    
func trigger_use(object_number):
    yield(get_tree(), "idle_frame")
    
func get_initial_rotation(previous_area):
    return 0
    
func play_fade_in(previous_area):
    return previous_area != null
    
func play_fade_out(next_area):
    return true
# -------------------------------------

func on_interact(object_number):
    get_tree().call_group("player_subtitles", "show_subtitles", get_description(object_number))

func on_use(object_number):
    get_tree().call_group("player", "lock_actions")
    yield(get_tree().create_timer(0.5), "timeout")
    yield(trigger_use(object_number), "completed")
    update_visibilities()
    if Global.hide_and_seek_started: Global.actions_in_darkness += 1
    yield(Monster.on_use(), "completed")
    SaveLoad.save()
    get_tree().call_group("player", "unlock_actions")
    
func say_yourself(text_line_1, text_line_2 = null):
    get_tree().call_group("you_screen", "start_showing", text_line_1, text_line_2)
    yield(get_tree().create_timer(3), "timeout")
    get_tree().call_group("you_screen", "stop_showing")
    
func say_dad(text_line_1, text_line_2 = null):
    get_tree().call_group("friendly_screen", "start_showing", text_line_1, text_line_2)
    yield(get_tree().create_timer(3), "timeout")
    get_tree().call_group("friendly_screen", "stop_showing")
    
func say_monster(text_line_1, text_line_2 = null):
    get_tree().call_group("monster_screen", "start_showing_legacy", text_line_1, text_line_2)
    yield(get_tree().create_timer(3), "timeout")
    get_tree().call_group("monster_screen", "stop_showing")
    
func say_monster_new(dialogue_id):
    yield($"../../MonsterScreen".start_showing(dialogue_id), "completed")

func show_blue_screen():
    get_tree().call_group("blue_screen", "start_showing")
    yield(get_tree().create_timer(2.5), "timeout")
    get_tree().call_group("blue_screen", "stop_showing")

func rotate_self_on_start(rotation_deg):
    transform.basis = Basis()
    rotate_y(deg2rad(rotation_deg))

func on_enter(previous_area):
    rotate_self_on_start(get_initial_rotation(previous_area))
    update_visibilities()
    add_to_group("area")
    if play_fade_in(previous_area):
        get_tree().call_group("ui", "fade_in")
    visible = true
    yield(init(previous_area), "completed")

func on_leave(next_area):
    if play_fade_out(next_area):
        get_tree().call_group("audio", "play", "Footsteps")
        get_tree().call_group("ui", "fade_out")
        yield(get_tree().create_timer(1), "timeout")
    else:
        yield(get_tree(), "idle_frame")
    visible = false
    remove_from_group("area")

func switch_areas(next_area):
    get_tree().call_group("main", "switch_areas", next_area)
    yield(get_tree().create_timer(1.5), "timeout")
    Global.reset_between_areas()
