extends Spatial

onready var selected_item = 0
onready var game_scene = preload("res://scenes/Main.tscn")

func _ready():
    SaveLoad.init()
    $TitleLabel.set_bbcode(_to_code(Global.takes))
    _update_selection()

func _to_code(number):
    if number < 10: return "R0000" + str(number)
    elif number < 100: return "R000" + str(number)
    elif number < 1000: return "R00" + str(number)
    elif number < 10000: return "R0" + str(number)
    elif number < 100000: return "R" + str(number)
    else: return "WHAT THE HECK"

func _update_selection(increment = 0):
    selected_item += increment
    if selected_item < 0: selected_item = 1
    elif selected_item > 1: selected_item = 0
    match selected_item:
        0: $Cursor.set_position(Vector2(620, 47))
        1: $Cursor.set_position(Vector2(620, 71))
    
func _on_select():
    match selected_item:
        0: get_tree().change_scene_to(game_scene)
        1: get_tree().change_scene("res://scenes/Outro.tscn")

func _process(_delta):
    if Input.is_action_just_pressed("ui_up"):
        _update_selection(-1)
    elif Input.is_action_just_pressed("ui_down"):
        _update_selection(1)    
    elif Input.is_action_just_pressed("ui_select") or Input.is_action_just_pressed("ui_accept"):
        _on_select()
