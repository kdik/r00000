extends RichTextLabel

func _ready():
    add_to_group("subtitles")

func show_subtitles(subtitles, timeout):
    var line = "[center]" + subtitles + "[/center]"
    self.set_bbcode(line)
    $AnimationPlayer.play("fade_in")
    yield(get_tree().create_timer(timeout), "timeout")
    $AnimationPlayer.play("fade_out")
    yield(get_tree().create_timer($AnimationPlayer.get_animation("fade_out").length + 0.5), "timeout")
