extends Control

func _ready():
    Input.connect("joy_connection_changed", self, "_on_joy_connection_changed")
    _set_scheme_visibility()

func _on_joy_connection_changed(device_id, connected):
    _set_scheme_visibility()

func _set_scheme_visibility():
    $Keyboard.visible = Input.get_connected_joypads().empty()
    $Controller.visible = not $Keyboard.visible
