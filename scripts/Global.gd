extends Node

# eternal
var takes = 0

# persistent between loops variables
var area = "Area01"
var have_flashlight = false
var battery_count = 0
var loops_completed = 0
var flashlight_on = false
var ending

# non persistent between loops variables
var lights_on = true
var actions_in_darkness = 0
var door_2_open = false
var door_3_open = false
var gate_3_open = false
var batteries_removed = false
var monster_introduced = false
var monster_defeated = false
var hide_and_seek_started = false
var hide_and_seek_lost = false

enum {ROOTS, CAUGHT, BECOME_EVIL, ESCAPE}

# Should only be used to delete footage
func reset_everything():
    reset()
    area = "Area01"
    takes = 0

func reset():
    area = "Area31"
    have_flashlight = false
    battery_count = 0
    loops_completed = 0
    flashlight_on = false
    reset_single_loop()
    
func reset_single_loop():
    lights_on = true
    actions_in_darkness = 0
    door_2_open = false
    door_3_open = false
    gate_3_open = false
    batteries_removed = false
    monster_introduced = false
    monster_defeated = false
    hide_and_seek_started = false
    hide_and_seek_lost = false
