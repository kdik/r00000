extends Node

func _ready():
    add_to_group("audio")

func play(sound_name):
    for child_node in get_children():
        if child_node.name == sound_name:
            print("Playing audio: " + sound_name)
            child_node.play()
