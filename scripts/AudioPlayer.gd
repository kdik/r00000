extends Node

func _ready():
    add_to_group("audio_player")

func play(sound_name):
    for child_node in get_children():
        if child_node.name == sound_name:
            print("Playing audio: " + sound_name)
            _start_playing(child_node)

func stop(sound_name):
    for child_node in get_children():
        if child_node.name == sound_name:
            print("Stopping audio: " + sound_name)
            _stop_playing(child_node)

func _stop_playing(sound : AudioStreamPlayer):
    if sound.is_playing(): sound.stop()
    
func _start_playing(sound : AudioStreamPlayer):
    if not sound.is_playing(): sound.play()
