#/Game/Player/
#Instanced from /Game
extends KinematicBody2D

#### Stats ####
var dead = false

func _ready():
	$Sprites.modulate.a = 0.99

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
		"dead" : dead,
	}
	return save_dict
