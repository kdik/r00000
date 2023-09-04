extends Node

var current_level = 0

func _ready():
    add_to_group("rumble")
    
func play(level = null):
    if level == null: current_level = _get_target_level()
    else: current_level = level
    if Settings.strong_rumble: Input.start_joy_vibration(0, 0, current_level)
    else: Input.start_joy_vibration(0, current_level, 0)
    
func stop():
    current_level = 0
    Input.stop_joy_vibration(0)
    
func pause():
    Input.stop_joy_vibration(0)
    
func resume():
    if Settings.strong_rumble: Input.start_joy_vibration(0, 0, current_level)
    else: Input.start_joy_vibration(0, current_level, 0)

func play_intro_sequence():
    for i in range(22): # framerate
        play(0.5 * i / 22.0)
        yield(get_tree(), "idle_frame")
    yield(get_tree(), "idle_frame")
    yield(play_load_sequence(), "completed")

func play_load_sequence():
    var target_level = _get_target_level()
    for i in range(15): # framerate
        play(target_level + (0.5 - target_level) * (15.0 - i) / 15.0)
        yield(get_tree(), "idle_frame")
    play(target_level)

func _get_target_level():
    var level = 0.0
    match int(Global.actions_in_darkness):
        0: level = 0.01
        1: level = 0.05
        2: level = 0.1
        3: level = 0.2
        4: level = 0.3
    return level
