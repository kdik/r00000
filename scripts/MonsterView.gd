extends MeshInstance

export var texture : StreamTexture


func _ready():
    add_to_group("monster_view")
    var material = mesh.surface_get_material(0).duplicate()
    mesh = mesh.duplicate()
    material.albedo_texture = texture
    mesh.surface_set_material(0, material)

func hide():
    visible = false
