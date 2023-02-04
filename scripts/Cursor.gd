extends Node2D

func _ready():
    add_to_group("crosshairs")

func in_sight(object_number):
    if $Inactive.visible and object_number > 0:
        $LeftHand.play("", false)
    elif $Active.visible and object_number == 0:
        $LeftHand.play("", true)
    $Active.visible = object_number > 0
    $Inactive.visible = object_number == 0
