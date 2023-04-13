extends TextureRect

func _process(anim_name):
    if not Global.hide_and_seek_started:
        material.set_shader_param("on", false)
        return
    match Global.actions_in_darkness:
        0:
            material.set_shader_param("on", true)
            material.set_shader_param("wobble_height", 1.0)
            material.set_shader_param("wobble_curve", 1.5)
            material.set_shader_param("wobble_speed", 1.0)
        1: 
            material.set_shader_param("wobble_height", 2.5)
            material.set_shader_param("wobble_curve", 5.0)
            material.set_shader_param("wobble_speed", 2.5)
        2: 
            material.set_shader_param("wobble_height", 5.0)
            material.set_shader_param("wobble_curve", 7.5)
            material.set_shader_param("wobble_speed", 5.0)
