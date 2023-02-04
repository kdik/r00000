extends Node2D

func _ready():
    add_to_group("crosshairs")

func in_sight(object_number):
    $Active.visible = object_number > 0
    $Inactive.visible = object_number == 0
