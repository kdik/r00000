extends RichTextLabel

func _ready():
    add_to_group("subtitles")

func show_subtitles(subtitles, timeout):
    var line = "[center]" + subtitles + "[/center]"
    self.set_bbcode(line)
    yield(get_tree().create_timer(timeout), "timeout")
