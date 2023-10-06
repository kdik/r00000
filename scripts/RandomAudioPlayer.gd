extends Node

var sound_players = [
    "RandomBasement1",
    "RandomBasement2",
    "RandomBasement3",
    "RandomBasement4",
    "RandomBasement5",
    "RandomBasement6",
    "RandomParanoia1",
    "RandomParanoia2",
    "RandomParanoia3",
    "RandomParanoia4",
    "RandomParanoia5"
]

func _ready():
    while true:
        var sleep_time = rand_range(30, 90)
        yield(get_tree().create_timer(sleep_time), "timeout")
        if Global.lights_on and not Global.monster_defeated:
            _play_random_sound()

func _play_random_sound():
    var sound_player_number = randi() % 11
    var sound_player_name = sound_players[sound_player_number]
    var sound_player = get_node(sound_player_name)
    sound_player.play()
    print("Playing random audio: " + sound_player_name)
