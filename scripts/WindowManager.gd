extends Node

func _ready():
    toggle_fullscreen_mode(Settings.enable_windowed)

func toggle_fullscreen_mode(windowed):
    if windowed: 
        OS.set_window_fullscreen(false)
        Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
    else: 
        OS.set_window_fullscreen(true)
        Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func is_fullscreen():
    return OS.is_window_fullscreen()
