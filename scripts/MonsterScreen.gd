extends ColorRect

func _ready():
    visible = false
    add_to_group("monster_screen")
    
func show():
    var text = "IT'S ME, BEHIND THE DOOR\nLET ME OUT"
    visible = true
    yield($Subtitles.show_subtitles("IT'S ME, BEHIND THE DOOR", 1.5), "completed")
    yield($Subtitles.show_subtitles("LET ME OUT", 1.5), "completed")

func hide():
    visible = false
