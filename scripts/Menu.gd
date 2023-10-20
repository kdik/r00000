extends Control

onready var selected_item = 0
onready var item_count
onready var play_number
onready var delete_footage_number
onready var credits_number
onready var eject_number
onready var windowed_fullscreen_number
onready var game_scene = preload("res://scenes/Main.tscn")
onready var locked = false

func _ready():
    YellowPaint.disable()
    if Settings.disable_crt: _disable_crt()
    if Settings.disable_border: _disable_border()
    SaveLoad.init()
    $TitleLabel.set_bbcode(_to_code(Global.takes))
    _set_selection_text()
    _update_selection()
    get_tree().call_group("audio_player", "stop", "NoSignal")
    get_tree().call_group("audio_player", "play", "TvBuzz")

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
        0: $Cursor.set_position(Vector2(620, 47))
        1: $Cursor.set_position(Vector2(620, 71))
        2: $Cursor.set_position(Vector2(620, 95))
        3: $Cursor.set_position(Vector2(620, 119))
        4: $Cursor.set_position(Vector2(620, 143))
    if increment != 0:
        get_tree().call_group("audio_player", "play", "TvMenuSelect", true)

func _on_select():
    match selected_item:
        play_number: _play()
        eject_number: _eject()
        delete_footage_number: _delete_footage()
        credits_number: _credits()
        windowed_fullscreen_number: _windowed_fullscreen()
        
func _set_selection_text():
    var text = ""
    if Global.area == "Area11":
        if Settings.enable_windowed:
            if WindowManager.is_fullscreen():
                text = _get_formatted_selection_text(["PLAY", "SET WINDOWED", "CREDITS", "EJECT"])
            else: 
                text = _get_formatted_selection_text(["PLAY", "SET FULLSCREEN", "CREDITS", "EJECT"])
            item_count = 4
            play_number = 0
            windowed_fullscreen_number = 1
            credits_number = 2
            eject_number = 3
            delete_footage_number = -1
        else:
            text = _get_formatted_selection_text(["PLAY", "CREDITS", "EJECT"])
            item_count = 3
            play_number = 0
            credits_number = 1
            eject_number = 2
            delete_footage_number = -1
            windowed_fullscreen_number = -1
    else:
        if Settings.enable_windowed:
            if WindowManager.is_fullscreen(): 
                text = _get_formatted_selection_text(["RESUME", "DELETE FOOTAGE", "SET WINDOWED", "CREDITS", "EJECT"])
            else:
                text = _get_formatted_selection_text(["RESUME", "DELETE FOOTAGE", "SET FULLSCREEN", "CREDITS", "EJECT"])
            item_count = 5
            play_number = 0
            delete_footage_number = 1
            windowed_fullscreen_number = 2
            credits_number = 3
            eject_number = 4
        else:
            text = _get_formatted_selection_text(["RESUME", "DELETE FOOTAGE", "CREDITS", "EJECT"])
            item_count = 4
            play_number = 0
            delete_footage_number = 1
            credits_number = 2
            eject_number = 3
            windowed_fullscreen_number = -1
    $SelectionLabel.set_bbcode(text)
    
func _get_formatted_selection_text(selections):
    var longest_selection = 0
    for selection in selections:
        if selection.length() > longest_selection: longest_selection = selection.length()
    var formatted_text = ""
    for selection in selections:
        formatted_text += "[right]"
        formatted_text += selection
        for i in range(longest_selection - selection.length()):
            formatted_text += " "
        formatted_text += "  [/right]"
    print(formatted_text)
    return formatted_text

func _play():
    get_tree().call_group("audio_player", "stop", "TvBuzz")
    if Global.area == "Area11":
        locked = true
        yield($VideoIntro.play_introduction(), "completed")
    get_tree().change_scene_to(game_scene)

func _eject():
    get_tree().change_scene("res://scenes/Outro.tscn")
    
func _credits():
    get_tree().call_group("audio_player", "stop", "TvBuzz")
    get_tree().change_scene("res://scenes/Credits.tscn")

func _delete_footage():
    locked = true
    get_tree().call_group("audio_player", "play", "DeleteFootage")
    if Global.ending_1_achieved and Global.ending_2_achieved and Global.ending_3_achieved and Global.ending_4_achieved:
        get_tree().call_group("achievements", "unlock_ocd")
    yield($MenuFilter.start_playing(), "completed")
    Global.reset_everything()
    SaveLoad.save()
    selected_item = 0
    _set_selection_text()
    _update_selection()
    $TitleLabel.set_bbcode(_to_code(Global.takes))
    yield(get_tree().create_timer(0.5), "timeout")
    yield($MenuFilter.stop_playing(), "completed")
    locked = false

func _windowed_fullscreen():
    var currently_fullscreen = WindowManager.is_fullscreen()
    WindowManager.toggle_fullscreen_mode(currently_fullscreen)
    _set_selection_text()

func _disable_crt():
    $CrtCurtain.visible = false

func _disable_border():
    var shift_diff = Vector2(20, 15)
    self.rect_position -= shift_diff

func _process(_delta):
    if locked: return
    if Input.is_action_just_pressed("ui_up"):
        _update_selection(-1)
    elif Input.is_action_just_pressed("ui_down"):
        _update_selection(1)    
    elif Input.is_action_just_pressed("ui_select") or Input.is_action_just_pressed("ui_accept"):
        _on_select()
