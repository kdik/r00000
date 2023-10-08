extends Node

var disable_crt = false
var strong_rumble = false
var disable_border = false
var yellow_paint = false

func _ready():
    disable_crt = _get_boolean_argument_value("disable-crt")
    strong_rumble = _get_boolean_argument_value("strong-rumble")
    disable_border = _get_boolean_argument_value("disable-border")
    yellow_paint = _get_boolean_argument_value("yellow-paint")

func _get_boolean_argument_value(key_name):
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

func _get_object_argument_value(key_name):
    var arguments = OS.get_cmdline_args()
    for argument in arguments:
        if argument.find("=") > -1:
            var key_value = argument.split("=")
            var key = key_value[0].replace("--", "")
            if key == key_name:
                return key_value[1]
    return null
