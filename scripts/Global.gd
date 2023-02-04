extends Node

var lights_on = true
var have_flashlight = false
var battery_count = 0
var actions_in_darkness = 0
var loops_completed = 0
var ending

enum {ROOTS, EVIL, WIN}

func reset():
    lights_on = true
    have_flashlight = false
    battery_count = 0
    actions_in_darkness = 0
    loops_completed = 0
