extends VideoPlayer

export var frame_count = 0

func _ready():
    visible = false

func show_dialogue():
    visible = true
    play()
    for _i in range(frame_count):
        yield(get_tree(), "idle_frame")
    visible = false
