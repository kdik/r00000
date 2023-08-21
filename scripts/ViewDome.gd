extends MeshInstance

onready var material = mesh.surface_get_material(0)

func _ready():
    add_to_group("view_dome")

func show_texture(texture_path):
    material.albedo_texture = load(texture_path)

func set_initial_rotation(rotation_deg):
    transform.basis = Basis()
    rotate_y(deg2rad(rotation_deg))
