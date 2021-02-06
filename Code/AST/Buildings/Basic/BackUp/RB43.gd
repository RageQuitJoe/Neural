# dim lights like roof


#/Game/TileGen/RM aka:Room Master
#Instanced from /Game/TileGen
extends Node2D
var free = true #Used in SaveLoad
var room_placed = false #Check if tile has been placed.
var double = false #Check if two tiles are ontop of each other.
var playon = false #Check if player is on tile
var time

func _ready():
	pass
	
func timer():
	$TimerRoof.set_wait_time(0.05)
	$TimerRoof.start()
	
func _on_TimerRoof_timeout(): # slowly modulate roof transparent
	var rcola = $Roof.modulate
	var rcolR = stepify(rcola[0],0.01)
	var rcolG = stepify(rcola[1],0.01)
	var rcolB = stepify(rcola[2],0.01)
	if playon == true: 
		time = time - 0.1
		if time >= 0:
			$Roof.modulate = Color(rcolR,rcolG,rcolB,float(time))
		else:
			$TimerRoof.stop()
	if playon == false: # slowly modulate roof opaque
		time = time + 0.1
		if time <= 1:
			$Roof.modulate = Color(rcolR,rcolG,rcolB,float(time))
		else:
			$TimerRoof.stop()
	
func _on_Double_area_entered(_area):
	double = true
	print("dt")
func _on_Double_area_exited(_area):
	double = false
	print("df")
func _on_PlayerOn_area_entered(_area):
	if $Light.visible == false:
		$Light.visible = not $Light.visible
	playon = true
	time = 1
	timer()
	print("pn")
	
func _on_PlayerOn_area_exited(_area):
	if $Light.visible == true:
		$Light.visible = not $Light.visible
	playon = false
	time = 0
	timer()
	print("px")
	
func _input(_event):	
	if Input.is_action_just_pressed("Accept") and room_placed == false: #Place Tile
		if double == true:
			pass
		else:
			room_placed = true
			get_node("/root/Game").re_ply_input()
	
	if Input.is_action_just_pressed("Rotate") and room_placed == false: #Rotate Tile
		rotation += PI/2
		
	if Input.is_action_just_pressed("Debug Delete") and room_placed == true and playon== true and get_parent().debug == true:
		call_deferred("free")#Close menu
		
	if Input.is_action_just_pressed("DUp") and room_placed == false:
		position = position + Vector2(0, -16)
	if Input.is_action_just_pressed("DDown") and room_placed == false:
		position = position +Vector2(0, 16)
	if Input.is_action_just_pressed("DLeft") and room_placed == false:
		position = position + Vector2(-16, 0)
	if Input.is_action_just_pressed("DRight") and room_placed == false:
		position = position + Vector2(16, 0)
	
func save():
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"name" : name,
		"pos_x" : position.x, # Vector2 is not supported by JSON
		"pos_y" : position.y,
		"free" : free,
	}
	return save_dict


