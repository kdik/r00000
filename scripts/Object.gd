extends MeshInstance

export var texture : StreamTexture
export var object_number : int = 1
export var description : String

func _ready():
    var material = mesh.surface_get_material(0).duplicate()
    mesh = mesh.duplicate()
    material.albedo_texture = texture
    material.albedo_color = Color(1.0, 1.0, 1.0, object_number)
    mesh.surface_set_material(0, material)
