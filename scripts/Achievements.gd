extends Node

onready var enabled

func _ready():
    enabled = ResourceLoader.exists("res://addons/godotsteam/godotsteam.gdns")
    add_to_group("achievements")

func _unlock(achievement):
    if not enabled:
        return
    Steam.Steam.setAchievement(achievement)
    Steam.Steam.storeStats()
    print("Unlocked achievement: " + achievement)

func unlock_fullstop():
    _unlock("NEW_ACHIEVEMENT_1_0")

func unlock_getalife():
    _unlock("NEW_ACHIEVEMENT_1_1")

func unlock_r00100():
    _unlock("NEW_ACHIEVEMENT_1_2")

func unlock_cheater():
    _unlock("NEW_ACHIEVEMENT_1_3")

func unlock_onemoretake():
    _unlock("NEW_ACHIEVEMENT_1_4")

func unlock_themonsterinme():
    _unlock("NEW_ACHIEVEMENT_1_5")
    
func unlock_theend():
    _unlock("NEW_ACHIEVEMENT_1_6")

func unlock_ocd():
    _unlock("NEW_ACHIEVEMENT_1_7")
