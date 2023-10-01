extends MeshInstance

onready var material = mesh.surface_get_material(0)
onready var color_free = Color(1.0, 1.0, 1.0, 0)
onready var color_object = Color(1.0, 1.0, 1.0, 1.0)

func _ready():
    clear()

func show_object(texture_path):
    material.albedo_texture = load(texture_path)
    material.albedo_color = color_object
    
func clear():
    material.albedo_color = color_free
