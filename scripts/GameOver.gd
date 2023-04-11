extends Spatial

func _ready():
    $Static.visible = true
    yield(get_tree().create_timer(1.5), "timeout")
    $Static.visible = false
    var text
    match Global.ending:
        Global.EVIL:
            text = "YOU WERE KILLED BY\nSOMETHING WICKED"
        Global.ROOTS:
            text = "YOU WERE KILLED BY\nTHE ROOTS IN YOUR HEAD"
        Global.WIN:
            text = "YOU HAVE BECOME\nTHE EVIL PRESENCE BEYOND THE DOOR"
    yield($Subtitles.show_subtitles(text, 5), "completed")
    $Subtitles.visible = false
    $Static.visible = true
    yield(get_tree(), "idle_frame")
    get_tree().change_scene("res://scenes/Menu.tscn")
