extends Spatial

func _ready():
    var text
    match Global.ending:
        Global.EVIL:
            text = "YOU WERE KILLED BY SOMETHING WICKED"
        Global.ROOTS:
            text = "YOU VENTURED TOO FAR AND THE ROOTS GOT YOU"
        Global.WIN:
            text = "YOU ARE WINNER XD"
    yield($Subtitles.show_subtitles(text, 5), "completed")
    yield(get_tree().create_timer(1.0), "timeout")
    get_tree().change_scene("res://scenes/Main.tscn")

func _process(_delta):
    if Input.is_action_just_pressed("ui_cancel"):
        get_tree().quit()
