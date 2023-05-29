class_name MonsterScreen
extends ColorRect

const DONT_YOU_WORRY = 1
const HELLO_MY_DEAR = 2
const MISS_ME = 3
const START_OVER_NOW = 4
const TURN_AWAY_NOW = 5
const YOUR_VIDEO_IS_A_DISGRACE = 6
const YOU_WANT_TO_PLAY_WITH_ME = 7
const BE_BETTER_YOU_HAVE_TO_BE_BETTER = 8
const DONT_YOU_DARE = 9
const FOOTAGE_STILL_NOT_GOOD_ENOUGH = 10
const IS_THIS_GOOD_ENOUGH = 11
const ONE_MORE = 12
const THIS_TIME_BE_BETTER = 13
const TWO_MORE = 14
const YOU_ARE_STUCK_WITH_ME = 15
const YOU_DO_NOT_NEED_THEM = 16
const IM_HERE_DONT_YOU_SEE = 17

func _ready():
    visible = false
    add_to_group("monster_screen")

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
        BE_BETTER_YOU_HAVE_TO_BE_BETTER: return $DialoguePlayer8
        DONT_YOU_DARE: return $DialoguePlayer9
        FOOTAGE_STILL_NOT_GOOD_ENOUGH: return $DialoguePlayer10
        IS_THIS_GOOD_ENOUGH: return $DialoguePlayer11
        ONE_MORE: return $DialoguePlayer12
        THIS_TIME_BE_BETTER: return $DialoguePlayer13
        TWO_MORE: return $DialoguePlayer14
        YOU_ARE_STUCK_WITH_ME: return $DialoguePlayer15
        YOU_DO_NOT_NEED_THEM: return $DialoguePlayer16
        IM_HERE_DONT_YOU_SEE: return $DialoguePlayer17

func _on_video_player_finished():
    visible = false
