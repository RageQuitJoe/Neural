#/Game/TileGen/BR4 aka:Room Master
#Instanced from /Game/TileGen
#### Notes ####
# collision mask must be set to 6 for weapons to not pass through it.
###############
extends Node2D

var placed = false #Check if tile has been placed.
var doubleplace #Check if two tiles are ontop of each other during player placement.
var removedf = false #Remove/Free DoubleFree if true 
var playon = false #Check if player is on tile

func _ready():
	if removedf == true: #Used when tile is not generated by WorldGen 
		$DoubleFree.call_deferred("free")
	if placed == false:
		modulate.a = 0.5
		set_z_index(10)

#### Double Check ####
func _on_DoubleFree_area_entered(_area): #Free tile if double during WorldGen
	call_deferred("free")

func _on_DoublePlace_area_entered(_area): #Check if double while placing tile.
	doubleplace = false
func _on_DoublePlace_area_exited(_area):
	doubleplace = true

#### Player On Check ####
func _on_PlayerOn_area_entered(_area):
	playon = true
func _on_PlayerOn_area_exited(_area):
	playon = false

func _input(_event):	
	if placed == false:
		timer()

func timer():
	$Timer.set_wait_time(0.1)
	$Timer.start()

func _on_Timer_timeout():
	if Input.is_action_pressed("Accept") and placed == false: #Place Tile
		get_tree().set_input_as_handled() 
		if doubleplace == false or playon == true:
			pass
		else:
			placed = true
			modulate.a = 1
			set_z_index(1)
			get_node("/root/Game/Default").player_inputon() #Re-enable player input.

	if Input.is_action_pressed("Rotate") and placed == false: #Rotate Tile
		get_tree().set_input_as_handled() 
		rotation += PI/2

	if Input.is_action_pressed("Delete") and placed == true and playon== true:
		get_tree().set_input_as_handled() 
		call_deferred("free")#Close menu

	if Input.is_action_pressed("DUp") and placed == false:
		get_tree().set_input_as_handled() 
		position = position + Vector2(0, -16)
	if Input.is_action_pressed("DDown") and placed == false:
		get_tree().set_input_as_handled() 
		position = position +Vector2(0, 16)
	if Input.is_action_pressed("DLeft") and placed == false:
		get_tree().set_input_as_handled() 
		position = position + Vector2(-16, 0)
	if Input.is_action_pressed("DRight") and placed == false:
		get_tree().set_input_as_handled() 
		position = position + Vector2(16, 0)
	if placed == true:
		$Timer.stop()

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