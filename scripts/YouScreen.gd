class_name YouScreen
extends ColorRect

const FUCK_THIS_FOOTAGE = 1
const I_CANNOT_USE_THEM_RIGHT_NOW = 2
const I_CAN_STILL_HEAR = 3
const TWO_MORE = 4
const I_DONT_NEED_THEM_ANYMORE = 5
const IS_LEAVE_POSSIBLE = 6
const NO_QUITTING = 7
const WHOS_TALKING = 8
const I_TOOK_THE_BATTERIES = 9
const WILL_I_EVER_BREAK_FREE = 10
const OUT_OF_ORDER = 11

var current_video_player

func _ready():
    visible = false
    add_to_group("you_screen")

func start_showing(dialogue_id):
    visible = true
    current_video_player = _get_video_player(dialogue_id)
    yield(current_video_player.show_dialogue(), "completed")
    visible = false

func _get_video_player(video_id):
    match video_id:
        FUCK_THIS_FOOTAGE: return $DialoguePlayer1
        I_CANNOT_USE_THEM_RIGHT_NOW: return $DialoguePlayer2
        I_CAN_STILL_HEAR: return $DialoguePlayer3
        TWO_MORE: return $DialoguePlayer4
        I_DONT_NEED_THEM_ANYMORE: return $DialoguePlayer5
        IS_LEAVE_POSSIBLE: return $DialoguePlayer6
        NO_QUITTING: return $DialoguePlayer7
        WHOS_TALKING: return $DialoguePlayer8
        I_TOOK_THE_BATTERIES: return $DialoguePlayer9
        WILL_I_EVER_BREAK_FREE: return $DialoguePlayer10
        OUT_OF_ORDER: return $DialoguePlayer11

func _on_video_player_finished():
    visible = false
    current_video_player.stop
