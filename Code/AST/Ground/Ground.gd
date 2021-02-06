#/Game/WorldGen/Ground
#Instanced from /Game/WorldGen/
extends Node2D
var placed = true
func _ready():
	pass
	
########Save########
var free = true #Used in /Game/SaveLoad.load_game()
func save():
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"name" : name,
		"pos_x" : position.x, # Vector2 is not supported by JSON
		"pos_y" : position.y,
		"free" : free,
		"placed" : placed,
	}
	return save_dict
