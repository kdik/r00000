extends Spatial

onready var material_1 = $Dome1.mesh.surface_get_material(0)
onready var material_2 = $Dome2.mesh.surface_get_material(0)
onready var material_3 = $Dome3.mesh.surface_get_material(0)
onready var material_4 = $Dome4.mesh.surface_get_material(0)
onready var color_0 = Color(1.0, 1.0, 1.0, 0)
onready var color_1 = Color(1.0, 1.0, 1.0, 1)
onready var color_2 = Color(1.0, 1.0, 1.0, 2)
onready var color_3 = Color(1.0, 1.0, 1.0, 3)
onready var color_4 = Color(1.0, 1.0, 1.0, 4)

func _ready():
    add_to_group("object_dome")

func add_object(texture_path, object_number):
    match object_number:
        1: 
            material_1.albedo_texture = load(texture_path)
            material_1.albedo_color = color_1
        2: 
            material_2.albedo_texture = load(texture_path)
            material_2.albedo_color = color_2
        3:
            material_3.albedo_texture = load(texture_path)
            material_3.albedo_color = color_3
        4: 
            material_4.albedo_texture = load(texture_path)
            material_4.albedo_color = color_4

func clear():
    material_1.albedo_color = color_0
    material_2.albedo_color = color_0
    material_3.albedo_color = color_0
    material_4.albedo_color = color_0

func set_initial_rotation(rotation_deg):
    transform.basis = Basis()
    rotate_y(deg2rad(rotation_deg))
