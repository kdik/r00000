extends Spatial

onready var movement = null
onready var player = get_parent()

func _ready():
    add_to_group("player_automated_movement")

func turn(end_x, end_y, max_time):
    get_tree().call_group("player", "lock_movement")
    var time = abs(end_y - player.rotation_y) / PI
    movement = { "start_x" : player.rotation_x, "start_y" : player.rotation_y, "end_x" : end_x, "end_y" : end_y, "elapsed_time" : 0.0, "target_time" : time }
    yield(get_tree().create_timer(time), "timeout")
    get_tree().call_group("player", "unlock_movement")

func _process(delta):
    if movement == null:
        return
    movement["elapsed_time"] = movement["elapsed_time"] + delta
    if movement["elapsed_time"] >= movement["target_time"]:
        movement = null
        return
    player.rotation_x = movement["start_x"] + (movement["end_x"] - movement["start_x"]) * movement["elapsed_time"] / movement["target_time"]
    player.rotation_y = movement["start_y"] + (movement["end_y"] - movement["start_y"]) * movement["elapsed_time"] / movement["target_time"]
    player.update_rotation()
