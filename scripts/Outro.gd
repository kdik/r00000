extends Control

onready var viewport_animation_player = $ViewportTexture/AnimationPlayer

func _ready():
    if Settings.disable_crt: _disable_crt()
    set_pause_mode(PAUSE_MODE_PROCESS)
    viewport_animation_player.play("turn_off")
    yield(get_tree().create_timer(viewport_animation_player.get_animation("turn_off").length + 0.5), "timeout")
    get_tree().quit()

func _disable_crt():
    var shift_diff = Vector2(20, 15)
    self.rect_position -= shift_diff
    $CrtCurtain.visible = false
