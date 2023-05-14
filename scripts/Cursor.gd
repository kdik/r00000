extends Node2D

onready var locked = false
onready var current_object_number = 0

func in_sight(object_number):
    if locked:
        return
    if object_number > 0:
        $LeftHand.play("", false)
        if current_object_number == 0:
            get_tree().call_group("area", "on_interact", object_number)
    elif object_number == 0:
        $LeftHand.play("", true)
        if current_object_number > 0:
            get_tree().call_group("player_subtitles", "fade_out")
    current_object_number = object_number

func lock():
    locked = true
    $LeftHand.play("", true)
    if current_object_number > 0:
        get_tree().call_group("player_subtitles", "fade_out")
        current_object_number = 0
    
func unlock():
    locked = false
