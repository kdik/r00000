extends RichTextLabel

enum {IDLE, SHOWING}
var state = IDLE

func _ready():
    add_to_group("player_subtitles")

func show_subtitles(subtitles, timeout = 0):
    if state != IDLE:
        return
    state = SHOWING
    var line = "[right]" + subtitles.to_upper() + "[/right]"
    self.set_bbcode(line)
    yield(fade_in(), "completed")
    if timeout > 0:
        yield(get_tree().create_timer(timeout), "timeout")
        yield(fade_out(), "completed")
    state = IDLE
        
func fade_in():
    $AnimationPlayer.play("fade_in")
    yield(get_tree().create_timer($AnimationPlayer.get_animation("fade_in").length), "timeout")
    
func fade_out():
    $AnimationPlayer.play("fade_out")
    yield(get_tree().create_timer($AnimationPlayer.get_animation("fade_out").length), "timeout")
    
