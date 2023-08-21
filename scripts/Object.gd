extends Spatial

export var object_number : int = 1
export var texture_path : String

func set_visibility(show):
    if show:
        get_tree().call_group("object_dome", "add_object", texture_path, object_number)
            
