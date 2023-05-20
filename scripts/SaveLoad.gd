extends Node

const FILENAME = "r00000.savefile"

var save_data : Dictionary = Dictionary()

func init():
    var file = File.new()
    file.open("user://" + FILENAME, File.READ)
    if not file.file_exists(file.get_path_absolute()):
        save()
    else:
        save_data = JSON.parse(file.get_as_text()).result
        _load_variables_from_save_data()

func save():
    _load_variables_to_save_data()
    var file = File.new()
    file.open("user://" + FILENAME, File.WRITE)
    file.store_string(to_json(save_data))
    file.close()

func _load_variables_to_save_data():
    for variable in Global.get_property_list():
        if variable["usage"] == PROPERTY_USAGE_SCRIPT_VARIABLE:
            var variable_name = variable["name"]
            save_data[variable_name] = Global.get(variable_name)

func _load_variables_from_save_data():
    print(save_data)
    for variable in save_data:
        Global.set(variable, save_data[variable])
