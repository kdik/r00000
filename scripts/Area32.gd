extends R00000Area

onready var object_1 = $Object1
onready var object_2 = $Object2
onready var object_3 = $Object3
onready var object_4 = $Object4

func get_initial_rotation(previous_area):
    if previous_area == "Area33": return 170
    else: return 0

func init(previous_area):
    if not Global.lights_on and not Global.hide_and_seek_started:
        yield(_introduce_monster(), "completed")
    if not Global.monster_introduced and not Global.monster_defeated:
        yield(say_monster("it's me, behind the door", "let me out"), "completed")
        Global.monster_introduced = true
    yield(get_tree(), "idle_frame")

func get_description(object_number):
    match object_number:
        object_1.object_number:
            if Global.door_2_open: return "go further"
            else: return "open the forsaken doors"
        object_2.object_number: return "take batteries"
        object_3.object_number: return "go further"
        object_4.object_number: return "go upstairs"
    
func trigger_use(object_number):
    match object_number:
        object_1.object_number:
            if Global.monster_defeated:
                if Global.door_2_open:
                    yield(switch_areas("Area35"), "completed")
                else:
                    Global.door_2_open = true
                    update_visibilities()
            else:
                if Global.hide_and_seek_started:
                    yield(say_yourself("the doors are sealed shut"), "completed")
                else:
                    Global.lights_on = false
                    Global.door_2_open = true
                    update_visibilities()
                    yield(_introduce_monster(), "completed")
                    Global.door_2_open = false
                    update_visibilities()
        object_2.object_number:
            if Global.battery_count < 3:
                Global.batteries_removed = true
                Global.lights_on = false
                update_visibilities()
            else:
                return yield(say_yourself("I don't need them"), "completed")
            if Global.have_flashlight:
                get_tree().call_group("player", "add_battery")
                yield(get_tree().create_timer(5), "timeout")
                if Global.battery_count == 1:
                    yield(say_yourself("two more left"), "completed")
                    yield(_introduce_monster(), "completed")
                elif Global.battery_count == 2:
                    yield(say_yourself("one more left"), "completed")
                    yield(_introduce_monster(), "completed")
                elif Global.battery_count == 3:
                    yield(say_yourself("that's it"), "completed")
                    Global.door_2_open = true
                    update_visibilities()
                    get_tree().call_group("player", "lock_movement")
                    yield(_look_at_monster(), "completed")
                    get_tree().call_group("player", "turn_on_flashlight")
                    get_tree().call_group("monster_eyes", "stop_showing")
                    get_tree().call_group("filter", "stop_playing")
                    get_tree().call_group("rumble", "stop")
                    get_tree().call_group("player", "unlock_movement")
                    Global.monster_defeated = true
            else:
                yield(say_yourself("my camera doesn't need them"), "completed")
                yield(_introduce_monster(), "completed")
        object_3.object_number:
            yield(switch_areas("Area33"), "completed")
        object_4.object_number:
            if Global.monster_defeated:
                switch_areas("Area31")
                yield(say_yourself("is... leave... possible?"), "completed")
            else:
                yield(switch_areas("Area31"), "completed")
    yield(get_tree(), "idle_frame")

func update_visibilities():
    $ViewLight.visible = Global.lights_on and not Global.door_3_open and not Global.gate_3_open and not Global.door_2_open
    $ViewLightDoor3Open.visible = Global.lights_on and Global.door_3_open and not Global.gate_3_open and not Global.door_2_open
    $ViewLightDoor3Gate3Open.visible = Global.lights_on and Global.door_3_open and Global.gate_3_open and not Global.door_2_open
    $ViewLightDoor2Open.visible = Global.lights_on and not Global.door_3_open and not Global.gate_3_open and Global.door_2_open
    $ViewLightDoor2Door3Open.visible = Global.lights_on and Global.door_3_open and not Global.gate_3_open and Global.door_2_open
    $ViewLightDoor2Door3Gate3Open.visible = Global.lights_on and Global.door_3_open and Global.gate_3_open and Global.door_2_open
    $ViewDark.visible = not Global.lights_on and not Global.door_3_open and not Global.gate_3_open and not Global.door_2_open
    $ViewDarkDoor3Open.visible = not Global.lights_on and Global.door_3_open and not Global.gate_3_open and not Global.door_2_open
    $ViewDarkDoor3Gate3Open.visible = not Global.lights_on and Global.door_3_open and Global.gate_3_open and not Global.door_2_open
    $ViewDarkDoor2Open.visible = not Global.lights_on and not Global.door_3_open and not Global.gate_3_open and Global.door_2_open
    $ViewDarkDoor2Door3Open.visible = not Global.lights_on and Global.door_3_open and not Global.gate_3_open and Global.door_2_open
    $ViewDarkDoor2Door3Gate3Open.visible = not Global.lights_on and Global.door_3_open and Global.gate_3_open and Global.door_2_open
    object_2.visible = Global.lights_on
    $Monster.visible = not Global.lights_on and Global.door_2_open and not Global.monster_defeated and not Global.hide_and_seek_started

func _introduce_monster():
    yield(Monster.introduce(_get_monster_coordinates(), "fade_out_near"), "completed")

func _look_at_monster():
    var monster_coordinates = _get_monster_coordinates()
    yield(get_tree().create_timer(1.5), "timeout")
    get_tree().call_group("player_automated_movement", "turn", monster_coordinates.x, monster_coordinates.y)
    yield(get_tree().create_timer(3), "timeout")  

func _get_monster_coordinates():
    var euler_rotation = global_transform.basis.get_euler()
    var monster_coordinates = Vector2(-0.19635, -2.159845)
    if euler_rotation.y > 0: monster_coordinates += Vector2(0, euler_rotation.y)
    return monster_coordinates
