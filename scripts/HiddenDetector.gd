extends Viewport

export var object_number : int = 1

func _ready():
    $HiddenDetectorCamera.set_object_number(object_number)

func object_in_sight():
    return $HiddenDetectorCamera.object_in_sight()
