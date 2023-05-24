extends ColorRect

func _ready():
    visible = false
    add_to_group("you_screen")
    
func start_showing(text_line_1, text_line_2 = null):
    visible = true
    if text_line_2 != null:
        yield($Subtitles.show_subtitles(text_line_1.to_upper(), 1.5), "completed")
        yield($Subtitles.show_subtitles(text_line_2.to_upper(), 1.5), "completed")
    else:
        yield($Subtitles.show_subtitles(text_line_1.to_upper(), 3), "completed")

func stop_showing():
    visible = false
