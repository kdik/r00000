extends ColorRect

onready var selected_item = 0
onready var item_count
onready var resume_number
onready var menu_number
onready var yellow_paint_number

func _ready():
    set_pause_mode(PAUSE_MODE_PROCESS)
    visible = false
    $TitleLabel.set_bbcode(_to_code(Global.takes))
    _set_selection_text()
    _update_selection()
    
func pause():
    visible = true
    _set_selection_text()
    _update_selection()
    get_tree().call_group("rumble", "pause")
    get_tree().call_group("audio_player", "play", "TvBuzz")
    
func resume():
    visible = false
    get_tree().paused = false
    get_tree().call_group("rumble", "resume")    
    get_tree().call_group("audio_player", "stop", "TvBuzz")

func go_to_menu():
    get_tree().paused = false
    get_tree().change_scene("res://scenes/Menu.tscn")

func enable_yellow_paint():
    YellowPaint.enable()
    get_tree().call_group("area", "update_visibilities")
    resume()

func _to_code(number):
    if number < 10: return "R0000" + str(number)
    elif number < 100: return "R000" + str(number)
    elif number < 1000: return "R00" + str(number)
    elif number < 10000: return "R0" + str(number)
    elif number < 100000: return "R" + str(number)
    else: return "WHAT THE HECK"

func _update_selection(increment = 0):
    selected_item += increment
    if selected_item < 0: selected_item = item_count - 1
    elif selected_item >= item_count: selected_item = 0
    match selected_item:
        0: $Cursor.set_position(Vector2(600, 32))
        1: $Cursor.set_position(Vector2(600, 56))
        2: $Cursor.set_position(Vector2(600, 80))
    if increment != 0:
        get_tree().call_group("audio_player", "play", "TvMenuSelect", true)
    $Cursor/White.visible = selected_item != yellow_paint_number
    $Cursor/Yellow.visible = selected_item == yellow_paint_number
    
func _on_select():
    match selected_item:
        resume_number: resume()
        menu_number: go_to_menu()
        yellow_paint_number: enable_yellow_paint()

func _process(_delta):
    if not visible:
        return 
    if Input.is_action_just_pressed("ui_up"):
        _update_selection(-1)
    elif Input.is_action_just_pressed("ui_down"):
        _update_selection(1)    
    elif Input.is_action_just_pressed("ui_select") or Input.is_action_just_pressed("ui_accept"):
        _on_select()
        
func _set_selection_text():
    selected_item = 0
    var text = ""
    if not YellowPaint.is_enabled() and YellowPaint.can_enable():
        text += "[right]RESUME  [/right]"
        text += "[right][color=#FFBF01]STUCK?  [/color][/right]"
        text += "[right]MENU    [/right]"
        item_count = 3
        resume_number = 0
        yellow_paint_number = 1
        menu_number = 2
    else:
        text += "[right]RESUME  [/right]"
        text += "[right]MENU    [/right]"
        item_count = 2
        resume_number = 0
        menu_number = 1
        yellow_paint_number = -1
    $SelectionLabel.set_bbcode(text)
    
