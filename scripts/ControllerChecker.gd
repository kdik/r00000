extends Node

var controller_connected = false

func _ready():
    Input.connect("joy_connection_changed", self, "_on_joy_connection_changed")
    _set_controller_status()

func _on_joy_connection_changed(device_id, connected):
    _set_controller_status()

func _set_controller_status():
    controller_connected = not Input.get_connected_joypads().empty()

func is_controller_connected():
    return controller_connected
