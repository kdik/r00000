extends MeshInstance

export var texture : StreamTexture

func _ready():
    var material = mesh.surface_get_material(0)
    material.albedo_texture = texture
