extends ColorRect

onready var animation_player = $AnimationPlayer

func _ready():
    add_to_group("ui")

func fade_in():
    animation_player.play("fade_in")
    yield(get_tree().create_timer(0.75), "timeout")

func fade_out():
    animation_player.play("fade_out")
    yield(get_tree().create_timer(0.75), "timeout")

func fade_out_fade_in():
    yield(fade_out(), "completed")
    yield(fade_in(), "completed")
