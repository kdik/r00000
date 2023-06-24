extends VideoPlayer

export var frame_count = 0

func _ready():
    visible = false

func show_dialogue():
    play()
    yield(get_tree(), "idle_frame")
    yield(get_tree(), "idle_frame")
    yield(get_tree(), "idle_frame")
    visible = true
    for _i in range(frame_count):
        yield(get_tree(), "idle_frame")
    visible = false
