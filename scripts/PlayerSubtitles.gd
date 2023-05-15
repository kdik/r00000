extends RichTextLabel

func _ready():
    add_to_group("player_subtitles")

func show_subtitles(subtitles, timeout = 0):
    var line = "[right]" + subtitles.to_upper() + "[/right]"
    self.set_bbcode(line)
    fade_in()
    if timeout > 0:
        yield(get_tree().create_timer(timeout), "timeout")
        fade_out()

func clear():
    self.set_bbcode("")
        
func fade_in():
    $AnimationPlayer.play("fade_in")
    
func fade_out():
    $AnimationPlayer.play("fade_out")
