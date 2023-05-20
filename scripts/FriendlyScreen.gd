extends ColorRect

func _ready():
    visible = false
    add_to_group("friendly_screen")
    
func display():
    visible = true
    yield($Subtitles.show_subtitles("UUUUU, ZE MONSTA IS\nWAITIN FOR YOU!", 3), "completed")
    yield($Subtitles.show_subtitles("LET ME OUT", 1.5), "completed")

func hide():
    visible = false