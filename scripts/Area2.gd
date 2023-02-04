extends Spatial

onready var object_1 = $Object1

func _ready():
    visible = false

func on_enter():
    visible = true
    add_to_group("area")
    
func on_leave():
    remove_from_group("area")

func on_interact(object_number):
    match object_number:
        object_1.object_number:
            get_tree().call_group("subtitles", "show_subtitles", "an evil presence awaits", 2)
            yield(get_tree().create_timer(3), "timeout")
    
func on_use(object_number):
    match object_number:
        object_1.object_number:
            get_tree().call_group("subtitles", "show_subtitles", "an evil presence awaits", 2)
            yield(get_tree().create_timer(3), "timeout")

func reset():
    pass
