extends MeshInstance

export var texture : StreamTexture

func _ready():
    var material = mesh.surface_get_material(0).duplicate()
    mesh = mesh.duplicate().duplicate()
    material.albedo_texture = texture
    mesh.surface_set_material(0, material)
