extends Node

# eternal
var takes = 0
var basement_escaped = false

# persistent between loops variables
var area = "Area11"
var have_flashlight = false
var battery_count = 0
var loops_completed = 0
var flashlight_on = false
var ending = null
var monster_defeated = false
var lights_on = true

# non persistent between loops variables
var actions_in_darkness = 0
var door_2_open = false
var door_3_open = false
var gate_3_open = false
var batteries_removed = false
var monster_introduced_take_1_12 = false
var monster_introduced_take_2_12 = false
var monster_introduced_take_2_23 = false
var monster_introduced_take_3_12 = false
var hide_and_seek_started = false
var hide_and_seek_lost = false
var used_cheat_code = false

# non persistent between areas variables
var door_1_open = false

enum {ROOTS, CAUGHT, BECOME_EVIL, ESCAPE}

# Should only be used to delete footage
func reset_everything():
    reset()
    area = "Area11"
    takes = 0
    basement_escaped = false

func reset():
    area = "Area31"
    have_flashlight = false
    battery_count = 0
    loops_completed = 0
    flashlight_on = false
    monster_defeated = false
    lights_on = true    
    reset_single_loop()
    
func reset_single_loop():
    actions_in_darkness = 0
    door_2_open = false
    door_3_open = false
    gate_3_open = false
    batteries_removed = false
    monster_introduced_take_3_12 = false
    monster_introduced_take_1_12 = false
    monster_introduced_take_2_12 = false
    monster_introduced_take_2_23 = false
    hide_and_seek_started = false
    hide_and_seek_lost = false
    used_cheat_code = false
    reset_between_areas()

func reset_between_areas():
    door_1_open = false
