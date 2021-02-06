#/Game/TileGen/Light 
#Instanced from /Game/World/Gen/TileGen
extends Node2D

var placed = false #Check if tile has been placed.
var playon = false #CHeck if player is on tile.

func _ready():
	pass

#### Player ON Check ####
func _on_PlayerOn_area_entered(_area):
	playon = true
func _on_PlayerOn_area_exited(_area):
	playon = false

func _input(_event):	
	if Input.is_action_just_pressed("Accept"): #Place Tile
		if placed == false:
			placed = true
			get_node("/root/Game").re_ply_input()
		if playon == true:
			$Light.visible = not $Light.visible

	if Input.is_action_just_pressed("Rotate") and placed == false: #Rotate Tile
		rotation += PI/2

	if Input.is_action_just_pressed("Delete") and placed == true and playon== true:
		call_deferred("free")#Close menu

	if Input.is_action_just_pressed("DUp") and placed == false:
		position = position + Vector2(0, -16)
	if Input.is_action_just_pressed("DDown") and placed == false:
		position = position +Vector2(0, 16)
	if Input.is_action_just_pressed("DLeft") and placed == false:
		position = position + Vector2(-16, 0)
	if Input.is_action_just_pressed("DRight") and placed == false:
		position = position + Vector2(16, 0)

#### Save ####
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


