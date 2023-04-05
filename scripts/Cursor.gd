extends Node2D

onready var locked = false

func _ready():
    add_to_group("crosshairs")

func in_sight(object_number):
    if locked:
        return
    if object_number > 0:
        $LeftHand.play("", false)
    elif object_number == 0:
        $LeftHand.play("", true)

func lock():
    locked = true
    $LeftHand.play("", true)
    
func unlock():
    locked = false
    $LeftHand.play("", false)
