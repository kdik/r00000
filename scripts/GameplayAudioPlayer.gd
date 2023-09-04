extends Node

onready var ambience_general = $AmbienceGeneral
onready var ambience_danger = $AmbienceDanger
onready var ambience_lamp = $AmbienceLamp
onready var ambience_outside = $AmbienceOutside

func _ready():
    add_to_group("gameplay_audio_player")

func pause():
    ambience_general.set_stream_paused(true)
    ambience_danger.set_stream_paused(true)
    ambience_lamp.set_stream_paused(true)
    ambience_outside.set_stream_paused(true)
    
func resume():
    ambience_general.set_stream_paused(false)
    ambience_danger.set_stream_paused(false)
    ambience_lamp.set_stream_paused(false)
    ambience_outside.set_stream_paused(false)
    
func play(sound_name, force = false):
    for child_node in get_children():
        if child_node.name == sound_name:
            print("Playing audio: " + sound_name)
            if force: child_node.play()
            else: _start_playing(child_node)

func stop(sound_name):
    for child_node in get_children():
        if child_node.name == sound_name:
            print("Stopping audio: " + sound_name)
            _stop_playing(child_node)
            
func _process(_delta):
    if not Global.lights_on and not Global.monster_defeated:
        _stop_playing(ambience_general)
        _start_playing(ambience_danger)
    else:
        _stop_playing(ambience_danger)
        if Global.area == "Area31" and Global.door_1_open:
            _stop_playing(ambience_general)
            _start_playing(ambience_outside)
        else:
            _stop_playing(ambience_outside)
            _start_playing(ambience_general)
    if Global.lights_on and (Global.area == "Area12" or Global.area == "Area13" or Global.area == "Area22" or Global.area == "Area23" or Global.area == "Area32" or Global.area == "Area33"):
        _start_playing(ambience_lamp)
    else:
        _stop_playing(ambience_lamp)
            
func _stop_playing(sound : AudioStreamPlayer):
    if sound.is_playing(): sound.stop()
    
func _start_playing(sound : AudioStreamPlayer):
    if not sound.is_playing(): sound.play()
