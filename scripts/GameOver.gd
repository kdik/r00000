extends Spatial

func _ready():
    var text
    match Global.ending:
        Global.EVIL:
            text = "YOU WERE KILLED BY\nSOMETHING WICKED"
        Global.ROOTS:
            text = "YOU WERE KILLED BY\nTHE ROOTS IN YOUR HEAD"
        Global.WIN:
            text = "YOU HAVE BECOME\nTHE EVIL PRESENCE BEYOND THE DOOR"
    yield($Subtitles.show_subtitles(text, 5), "completed")
    yield(get_tree().create_timer(1.0), "timeout")
    get_tree().change_scene("res://scenes/Main.tscn")

func _process(_delta):
    if Input.is_action_just_pressed("ui_cancel"):
        get_tree().quit()
