extends Node

onready var ambience_general = $AmbienceGeneral
onready var ambience_danger = $AmbienceDanger

func _ready():
    add_to_group("audio")
    ambience_general.play()

func play(sound_name):
    for child_node in get_children():
        if child_node.name == sound_name:
            print("Playing audio: " + sound_name)
            child_node.play()
            
func _process(_delta):
    if not Global.lights_on and not Global.flashlight_on:
        if not ambience_danger.is_playing():
            ambience_general.stop()
            ambience_danger.play()
    else:
        if not ambience_general.is_playing():
            ambience_danger.stop()
            ambience_general.play()
