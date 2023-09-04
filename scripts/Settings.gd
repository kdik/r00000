extends Node

var disable_crt = false
var strong_rumble = false

func _ready():
    disable_crt = _get_argument_value("disable-crt")
    strong_rumble = _get_argument_value("strong-rumble")

func _get_argument_value(key_name):
    var arguments = OS.get_cmdline_args()
    for argument in arguments:
        if argument.find("=") > -1:
            var key_value = argument.split("=")
            var key = key_value[0].replace("--", "")
            if key == key_name:
                return key_value[1]
        else:
            if key_name == argument.replace("--", ""):
                return true
    return false
