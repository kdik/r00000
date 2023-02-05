extends AnimatedSprite

func _ready():
    visible = false

func _process(_delta):
    match Global.loops_completed:
        1: if not is_playing(): 
            visible = true
            play("level_1")
        2: if get_animation() != "level_2": play("level_2")
        3: if get_animation() != "level_3": play("level_3")
        4: if get_animation() != "level_4": play("level_4")
        5: if get_animation() != "level_5": play("level_5")
