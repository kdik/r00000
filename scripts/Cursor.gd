extends Node2D

func _ready():
    add_to_group("crosshairs")

func in_sight(object_number):
    print(object_number)
    if object_number > 0:
        $Active.visible = true
        $Inactive.visible = false
    else:
        $Active.visible = false
        $Inactive.visible = true
