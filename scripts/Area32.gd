extends R00000Area

onready var object_1 = $Object1
onready var object_2 = $Object2
onready var object_3 = $Object3
onready var object_4 = $Object4

func play_fade_out(next_area):
    return next_area != "Area35"

func get_initial_rotation(previous_area):
    if previous_area == "Area33": return 170
    else: return 0

func init(previous_area):
    if _should_illuminate_monster():
        yield(get_tree(), "idle_frame")
        return
    if not Global.monster_introduced_take_3_12 and not Global.monster_defeated:
        yield(say_monster(MonsterScreen.THIS_TIME_BE_BETTER), "completed")
        Global.monster_introduced_take_3_12 = true
    yield(get_tree(), "idle_frame")

func get_description(object_number):
    match object_number:
        object_1.object_number:
            if _should_illuminate_monster(): return "goodbye"
            elif Global.door_2_open: return "become the other"
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
                    get_tree().call_group("audio_player", "play", "DoorRegular")
                    Global.door_2_open = true
                    update_visibilities()
            elif _should_illuminate_monster():
                get_tree().call_group("player", "lock_movement")
                get_tree().call_group("player", "show_middle_finger")
                get_tree().call_group("audio_player", "play", "EyesLitUp")
                yield(get_tree().create_timer(38.0 / 15.0 + 0.5), "timeout")
                get_tree().call_group("player", "turn_on_flashlight")
                get_tree().call_group("monster_eyes", "stop_showing")
                get_tree().call_group("filter", "stop_playing")
                get_tree().call_group("rumble", "stop")
                Global.monster_defeated = true
                update_visibilities()
                if Global.used_cheat_code: get_tree().call_group("achievements", "unlock_cheater")
                yield(get_tree().create_timer(0.5), "timeout")
                get_tree().call_group("player", "unlock_movement")
            else:
                if Global.hide_and_seek_started:
                    yield(say_monster(MonsterScreen.IM_HERE_DONT_YOU_SEE), "completed")
                else:
                    get_tree().call_group("audio_player", "play", "DoorRegular")
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
                return yield(say_yourself(YouScreen.I_DONT_NEED_THEM_ANYMORE), "completed")
            if Global.have_flashlight:
                get_tree().call_group("player", "add_battery")
                yield(get_tree().create_timer(4), "timeout")
                if Global.battery_count == 1:
                    yield(say_monster(MonsterScreen.TWO_MORE), "completed")
                    yield(_introduce_monster(), "completed")
                elif Global.battery_count == 2:
                    yield(say_monster(MonsterScreen.TWO_MORE), "completed")
                    yield(_introduce_monster(), "completed")
                elif Global.battery_count == 3:
                    yield(say_monster(MonsterScreen.DONT_YOU_DARE), "completed")
                    Global.door_2_open = true
                    update_visibilities()
                    get_tree().call_group("player", "lock_movement")
                    yield(_look_at_monster(), "completed")
                    get_tree().call_group("player", "unlock_movement")
            else:
                yield(say_monster(MonsterScreen.YOU_DO_NOT_NEED_THEM), "completed")
                yield(_introduce_monster(), "completed")
        object_3.object_number:
            yield(switch_areas("Area33"), "completed")
        object_4.object_number:
            if Global.monster_defeated:
                switch_areas("Area31")
                yield(say_yourself(YouScreen.IS_LEAVE_POSSIBLE), "completed")
            else:
                yield(switch_areas("Area31"), "completed")
    yield(get_tree(), "idle_frame")

func update_visibilities():
    $ViewLight.set_visibility(Global.lights_on and not Global.door_3_open and not Global.gate_3_open and not Global.door_2_open and not YellowPaint.is_enabled())
    $ViewLightDoor3Open.set_visibility(Global.lights_on and Global.door_3_open and not Global.gate_3_open and not Global.door_2_open and not YellowPaint.is_enabled())
    $ViewLightDoor3Gate3Open.set_visibility(Global.lights_on and Global.door_3_open and Global.gate_3_open and not Global.door_2_open and not YellowPaint.is_enabled())
    $ViewLightDoor2Open.set_visibility(Global.lights_on and not Global.door_3_open and not Global.gate_3_open and Global.door_2_open)
    $ViewLightDoor2Door3Open.set_visibility(Global.lights_on and Global.door_3_open and not Global.gate_3_open and Global.door_2_open)
    $ViewLightDoor2Door3Gate3Open.set_visibility(Global.lights_on and Global.door_3_open and Global.gate_3_open and Global.door_2_open)
    $ViewDark.set_visibility(not Global.lights_on and not Global.door_3_open and not Global.gate_3_open and not Global.door_2_open)
    $ViewDarkDoor3Open.set_visibility(not Global.lights_on and Global.door_3_open and not Global.gate_3_open and not Global.door_2_open)
    $ViewDarkDoor3Gate3Open.set_visibility(not Global.lights_on and Global.door_3_open and Global.gate_3_open and not Global.door_2_open)
    $ViewDarkDoor2Open.set_visibility(not Global.lights_on and not Global.door_3_open and not Global.gate_3_open and Global.door_2_open)
    $ViewDarkDoor2Door3Open.set_visibility(not Global.lights_on and Global.door_3_open and not Global.gate_3_open and Global.door_2_open)
    $ViewDarkDoor2Door3Gate3Open.set_visibility(not Global.lights_on and Global.door_3_open and Global.gate_3_open and Global.door_2_open)
    $Monster.visible = not Global.lights_on and Global.door_2_open and not Global.monster_defeated and not Global.hide_and_seek_started
    get_tree().call_group("decal_dome", "clear")
    $DecalTagIn.set_visibility(Global.monster_defeated and Global.loops_completed_after_defeating_monster == 1)
    $DecalTagYour.set_visibility(Global.monster_defeated and Global.loops_completed_after_defeating_monster == 2)
    $DecalTagHead.set_visibility(Global.monster_defeated and Global.loops_completed_after_defeating_monster == 3)
    get_tree().call_group("object_dome", "clear")
    object_1.set_visibility(true)
    object_2.set_visibility(Global.lights_on and not _should_illuminate_monster())
    object_3.set_visibility(not _should_illuminate_monster())
    object_4.set_visibility(not _should_illuminate_monster())
    # yellow paint
    $ViewLightHint.set_visibility(Global.lights_on and not Global.door_3_open and not Global.gate_3_open and not Global.door_2_open and YellowPaint.is_enabled())
    $ViewLightDoor3OpenHint.set_visibility(Global.lights_on and Global.door_3_open and not Global.gate_3_open and not Global.door_2_open and YellowPaint.is_enabled())
    $ViewLightDoor3Gate3OpenHint.set_visibility(Global.lights_on and Global.door_3_open and Global.gate_3_open and not Global.door_2_open and YellowPaint.is_enabled())

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
    
func _should_illuminate_monster():
    return not Global.monster_defeated and int(Global.battery_count) >= 3
