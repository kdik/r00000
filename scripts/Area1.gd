extends Spatial

onready var object_1 = $Object1
onready var object_2 = $Object2

func _ready():
    visible = false

func on_enter():
    visible = true
    add_to_group("area")
    
func on_leave():
    visible = false
    remove_from_group("area")

func on_interact(object_number):
    match object_number:
        object_1.object_number:
            get_tree().call_group("subtitles", "show_subtitles", "no way I'm going down there", 2)
            yield(get_tree().create_timer(3), "timeout")
        object_2.object_number:
            get_tree().call_group("subtitles", "show_subtitles", "the door is locked", 2)
            yield(get_tree().create_timer(3), "timeout")
    
func on_use(object_number):
    match object_number:
        object_1.object_number:
            get_tree().call_group("main", "switch_areas", "Area2")
        object_2.object_number:
            get_tree().call_group("subtitles", "show_subtitles", "the door is locked", 2)
            yield(get_tree().create_timer(3), "timeout")
