extends Node

func _ready():
    add_to_group("achievements")

func _unlock(achievement):
    #Steam.setAchievement(achievement)
    #Steam.storeStats()
    print("Achievement unlocked: " + achievement)

func unlock_headache():
    _unlock("headache?")

func unlock_getalife():
    _unlock("getalife")

func unlock_r00100():
    _unlock("r00100")

func unlock_cheater():
    _unlock("cheater")

func unlock_onemoretake():
    _unlock("onemoretake")

func unlock_themonsterinme():
    _unlock("themonsterinme")
    
func unlock_theend():
    _unlock("theend")

func unlock_ocd():
    _unlock("ocd")
