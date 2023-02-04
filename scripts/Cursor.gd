extends Node2D

func _ready():
    add_to_group("crosshairs")

func in_sight(object_number):
    if $Target/Inactive.visible and object_number > 0:
        $LeftHand.play("", false)
    elif $Target/Active.visible and object_number == 0:
        $LeftHand.play("", true)
    $Target/Active.visible = object_number > 0
    $Target/Inactive.visible = object_number == 0
