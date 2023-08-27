extends Control

const VIDEO_1 = 1
const VIDEO_1_1 = 2
const VIDEO_2 = 3
const VIDEO_2_1 = 4
const VIDEO_3 = 5
const VIDEO_4 = 6

var finished = false

func _ready():
    add_to_group("rewind")
    visible = false

func play(video_number):
    finished = false
    visible = true
    var video_player
    match video_number:
        VIDEO_1: video_player = $VideoPlayer1
        VIDEO_1_1: video_player = $VideoPlayer11
        VIDEO_2: video_player = $VideoPlayer2
        VIDEO_2_1: video_player = $VideoPlayer21
        VIDEO_3: video_player = $VideoPlayer3
        VIDEO_4: video_player = $VideoPlayer4
    video_player.play()
    video_player.visible = true
    while not finished:
        yield(get_tree(), "idle_frame")
    video_player.stop()
    visible = false
    video_player.visible = false

func _on_video_finished():
    finished = true
