extends Spatial

onready var transparent_texture = preload("res://images/transparent.png")
onready var material_1 = $DecalDome1.mesh.surface_get_material(0)
onready var material_2 = $DecalDome2.mesh.surface_get_material(0)

func _ready():
    add_to_group("decal_dome")
    $DecalDome1.visible = false
    $DecalDome2.visible = false

func show_texture(texture_path):
    if not $DecalDome1.visible:
        material_1.albedo_texture = load(texture_path)
        $DecalDome1.visible = true
    elif not $DecalDome2.visible:
        material_2.albedo_texture = load(texture_path)
        $DecalDome2.visible = true

func clear():
    if $DecalDome1.visible:
        material_1.albedo_texture = transparent_texture
    if $DecalDome2.visible:
        material_2.albedo_texture = transparent_texture
    $DecalDome1.visible = false
    $DecalDome2.visible = false

func set_initial_rotation(rotation_deg):
    transform.basis = Basis()
    rotate_y(deg2rad(rotation_deg))
