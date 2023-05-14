extends AnimatedSprite

func _ready():
    add_to_group("left_hand")
    
func open():
    play("", false)
    
func close():
    play("", true)
