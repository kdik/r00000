extends Spatial

export(String) var texture_path = ""

func set_visibility(show):
    if show:
        get_tree().call_group("decal_dome", "show_texture", texture_path)
