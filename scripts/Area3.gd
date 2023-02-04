extends Spatial

var flashlight_count = 1

func _ready():
    visible = false

func on_enter():
    visible = true
    add_to_group("area")
    
func on_leave():
    remove_from_group("area")

func on_interact(object_number):
    pass
    
func on_use(object_number):
    pass

func reset():
    pass
