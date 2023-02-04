extends Spatial

func _ready():
    yield($Subtitles.show_subtitles("YOU WERE KILLED BY SOMETHING WICKED", 5), "completed")
    yield(get_tree().create_timer(1.0), "timeout")
    get_tree().change_scene("res://scenes/Main.tscn")

func _process(_delta):
    if Input.is_action_just_pressed("ui_cancel"):
        get_tree().quit()
