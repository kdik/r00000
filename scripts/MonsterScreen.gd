class_name MonsterScreen
extends ColorRect

const DONT_YOU_WORRY = 1
const HELLO_MY_DEAR = 2
const MISS_ME = 3
const START_OVER_NOW = 4
const TURN_AWAY_NOW = 5
const YOUR_VIDEO_IS_A_DISGRACE = 6
const YOU_WANT_TO_PLAY_WITH_ME = 7

func _ready():
    visible = false
    add_to_group("monster_screen")
    
func start_showing_legacy(text_line_1, text_line_2 = null):
    visible = true
    if text_line_2 != null:
        yield($Subtitles.show_subtitles(text_line_1.to_upper(), 1.5), "completed")
        yield($Subtitles.show_subtitles(text_line_2.to_upper(), 1.5), "completed")
    else:
        yield($Subtitles.show_subtitles(text_line_1.to_upper(), 3), "completed")

func stop_showing():
    visible = false

func start_showing(dialogue_id):
    visible = true
    yield(_get_video_player(dialogue_id).show_dialogue(), "completed")
    visible = false
    
func get_frame_count(dialogue_id):
    return _get_video_player(dialogue_id).get_frame_count()

func _get_video_player(video_id):
    match video_id:
        DONT_YOU_WORRY: return $DialoguePlayer1
        HELLO_MY_DEAR: return $DialoguePlayer2
        MISS_ME: return $DialoguePlayer3
        START_OVER_NOW: return $DialoguePlayer4
        TURN_AWAY_NOW: return $DialoguePlayer5
        YOUR_VIDEO_IS_A_DISGRACE: return $DialoguePlayer6
        YOU_WANT_TO_PLAY_WITH_ME: return $DialoguePlayer7

func _on_video_player_finished():
    visible = false
