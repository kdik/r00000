extends R00000Area

onready var object_1 = $Object1
onready var object_2 = $Object2
onready var object_3 = $Object3
onready var object_4 = $Object4

func play_fade_out(next_area):
    return next_area != "Area31" and (Global.have_flashlight or next_area != "Area34")

func get_initial_rotation(previous_area):
    if previous_area == "Area32": return 135
    else: return 0

func get_description(object_number):
    match object_number:
        object_1.object_number: 
            if _should_illuminate_monster(): return "goodbye"
            else: return "go back"
        object_2.object_number: return "crawl deeper"
        object_3.object_number:
            if Global.hide_and_seek_started and not Global.monster_defeated:
                return "escape"
            else:
                if not Global.door_3_open: return "open doors"
                elif not Global.gate_3_open: return "open gates"
                else: return "retake footage"
        object_4.object_number: return "take batteries"

func trigger_use(object_number):
    match object_number:
        object_1.object_number: 
            if _should_illuminate_monster():
                get_tree().call_group("player", "lock_movement")
                get_tree().call_group("player", "show_middle_finger")
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
                yield(switch_areas("Area32"), "completed")
        object_2.object_number: yield(switch_areas("Area34"), "completed")
        object_3.object_number:
            if not Global.door_3_open:
                Global.door_3_open = true
                get_tree().call_group("audio_player", "play", "DoorRegular")
            elif not Global.gate_3_open:
                Global.gate_3_open = true
                get_tree().call_group("audio_player", "play", "DoorMetal")
            else:
                var hide_and_seek_started = Global.hide_and_seek_started
                Global.takes += 1
                Global.loops_completed += 1
                if not Global.monster_defeated: Global.lights_on = true
                Global.reset_single_loop()
                switch_areas("Area31")
                if Global.monster_defeated:
                    yield(say_yourself(YouScreen.FUCK_THIS_FOOTAGE), "completed")
                    yield($"../../Rewind".play($"../../Rewind".VIDEO_4), "completed")
                elif hide_and_seek_started: 
                    yield(say_monster(MonsterScreen.FOOTAGE_STILL_NOT_GOOD_ENOUGH), "completed")
                    yield($"../../Rewind".play($"../../Rewind".VIDEO_3), "completed")
                else: 
                    yield(say_monster(MonsterScreen.BE_BETTER_YOU_HAVE_TO_BE_BETTER), "completed")
                    if Global.lights_on: yield($"../../Rewind".play($"../../Rewind".VIDEO_1), "completed")
                    else: yield($"../../Rewind".play($"../../Rewind".VIDEO_1_1), "completed")
                yield(show_blue_screen(), "completed")
                get_tree().call_group("monster_eyes", "stop_showing")
                get_tree().call_group("filter", "stop_playing")
                get_tree().call_group("rumble", "stop")
        object_4.object_number:
            if Global.battery_count < 3:
                Global.batteries_removed = true
                Global.lights_on = false
                update_visibilities()
            else:
                return yield(say_yourself("I do not need them"), "completed")
            if Global.have_flashlight:
                get_tree().call_group("player", "add_battery")
                yield(get_tree().create_timer(4), "timeout")
                if Global.battery_count == 1:
                    yield(say_monster(MonsterScreen.TWO_MORE), "completed")
                    yield(_introduce_monster(), "completed")
                elif Global.battery_count == 2:
                    yield(say_monster(MonsterScreen.ONE_MORE), "completed")
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
    yield(get_tree(), "idle_frame")

func update_visibilities():
    $ViewLight.set_visibility(Global.lights_on and not Global.door_3_open and not Global.gate_3_open and not Global.door_2_open)
    $ViewLightDoor3Open.set_visibility(Global.lights_on and Global.door_3_open and not Global.gate_3_open and not Global.door_2_open)
    $ViewLightDoor3Gate3Open.set_visibility(Global.lights_on and Global.door_3_open and Global.gate_3_open and not Global.door_2_open)
    $ViewLightDoor2Open.set_visibility(Global.lights_on and not Global.door_3_open and not Global.gate_3_open and Global.door_2_open)
    $ViewLightDoor2Door3Open.set_visibility(Global.lights_on and Global.door_3_open and not Global.gate_3_open and Global.door_2_open)
    $ViewLightDoor2Door3Gate3Open.set_visibility(Global.lights_on and Global.door_3_open and Global.gate_3_open and Global.door_2_open)
    $ViewDark.set_visibility(not Global.lights_on and not Global.door_3_open and not Global.gate_3_open and not Global.door_2_open)
    $ViewDarkDoor3Open.set_visibility(not Global.lights_on and Global.door_3_open and not Global.gate_3_open and not Global.door_2_open)
    $ViewDarkDoor3Gate3Open.set_visibility(not Global.lights_on and Global.door_3_open and Global.gate_3_open and not Global.door_2_open)
    $ViewDarkDoor2Open.set_visibility(not Global.lights_on and not Global.door_3_open and not Global.gate_3_open and Global.door_2_open)
    $ViewDarkDoor2Door3Open.set_visibility(not Global.lights_on and Global.door_3_open and not Global.gate_3_open and Global.door_2_open)
    $ViewDarkDoor2Door3Gate3Open.set_visibility(not Global.lights_on and Global.door_3_open and Global.gate_3_open and Global.door_2_open)
    $DecalGraffiti.set_visibility(Global.lights_on)
    $DecalFlashlight.set_visibility(Global.lights_on and not Global.have_flashlight)
    $Monster.visible = not Global.lights_on and Global.door_2_open and not Global.monster_defeated and not Global.hide_and_seek_started
    get_tree().call_group("object_dome", "clear")
    object_1.set_visibility(true)
    object_2.set_visibility(not _should_illuminate_monster())
    object_3.set_visibility(not _should_illuminate_monster())
    object_4.set_visibility(Global.lights_on and not _should_illuminate_monster())

func _introduce_monster():
    yield(Monster.introduce(_get_monster_coordinates(), "fade_out_far"), "completed")
    
func _look_at_monster():
    var monster_coordinates = _get_monster_coordinates()
    yield(get_tree().create_timer(1.5), "timeout")
    get_tree().call_group("player_automated_movement", "turn", monster_coordinates.x, monster_coordinates.y)
    yield(get_tree().create_timer(3), "timeout")  

func _get_monster_coordinates():
    var euler_rotation = global_transform.basis.get_euler()
    var monster_coordinates = Vector2(-0.1309, 2.552544)
    if euler_rotation.y == 0: monster_coordinates -= Vector2(0, deg2rad(135))
    return monster_coordinates
    
func _should_illuminate_monster():
    return not Global.monster_defeated and int(Global.battery_count) >= 3
