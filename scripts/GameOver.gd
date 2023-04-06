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
    get_tree().change_scene("res://scenes/Menu.tscn")
