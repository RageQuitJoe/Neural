#/Game/Player/Light/Main
#Node of /Game/Player/Light
extends Light2D

func _ready():
	pass 

#### Save ####
var free = false #Used in /Game/SaveLoad.load_game()
func save():
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"name" : name,
		"pos_x" : position.x, # Vector2 is not supported by JSON
		"pos_y" : position.y,
		"free" : free,
		"visible" : visible,
	}
	return save_dict
