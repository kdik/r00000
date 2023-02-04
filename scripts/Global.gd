extends Node

# persistent between loops variables
var have_flashlight = false
var battery_count = 0
var loops_completed = 0
var ending

# non persistent between loops variables 
var lights_on = true
var actions_in_darkness = 0
var door_3_open = false
var gate_3_open = false

enum {ROOTS, EVIL, WIN}

func reset():
    lights_on = true
    have_flashlight = false
    battery_count = 0
    actions_in_darkness = 0
    loops_completed = 0
    ending = null
    
func reset_single_loop():
    lights_on = true
    actions_in_darkness = 0
    door_3_open = false
    gate_3_open = false
