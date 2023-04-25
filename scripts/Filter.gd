extends VideoPlayer

func _ready():
    add_to_group("filter")

func show():
    if not is_playing(): play()
    
func stop():
    if is_playing(): stop()
    
func set_alpha(alpha):
    material.set_shader_param("alpha", alpha)

func _on_finished():
    play()
