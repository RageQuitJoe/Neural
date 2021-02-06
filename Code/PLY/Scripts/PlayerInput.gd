#/Game/Player/PlayerInput
#Instanced from Player
extends Node2D

onready var player = get_parent()
onready var camera = get_node("../Camera")

#### Ready ####
func _ready():
	pass

#### Input ####
func _input(event):

	#### Menu ####
	if Input.is_action_just_pressed("Menu"): #Menu
		get_tree().set_input_as_handled() 
		call_deferred("free")
		get_node("/root/Game/HUD/CanvasLayer").call_deferred("add_child",load("res://MNU/Inventory.tscn").instance()) #Load Inventory
	if event.is_action_released("Options"):
		pass

	#### Light ####
	if Input.is_action_just_pressed("Light"):
		get_tree().set_input_as_handled() 
		get_node("../Light/Main").visible = not get_node("../Light/Main").visible
		if get_node("../Light/Main").visible == true:
			get_node("../Battery").battery_drain += get_node("/root/Game/Default").mainlight_drain
		if get_node("../Light/Main").visible == false:
			get_node("../Battery").battery_drain -= get_node("/root/Game/Default").mainlight_drain

	#### Zoom ####
	if Input.is_action_pressed("Zoom In") and Input.is_action_pressed("Zoom Out"):
		get_tree().set_input_as_handled() 
		camera.zoom = get_node("/root/Game/Default").start_zoom
	if Input.is_action_just_pressed("Zoom In"):
		get_tree().set_input_as_handled() 
		if camera.zoom > Vector2(get_node("/root/Game/Default").min_zoom,get_node("/root/Game/Default").min_zoom):
			camera.zoom = camera.zoom - Vector2(get_node("/root/Game/Default").zoom_step,get_node("/root/Game/Default").zoom_step)
	if Input.is_action_just_pressed("Zoom Out"):
		get_tree().set_input_as_handled() 
		if camera.zoom < Vector2(get_node("/root/Game/Default").max_zoom,get_node("/root/Game/Default").max_zoom):
			camera.zoom = camera.zoom + Vector2(get_node("/root/Game/Default").zoom_step,get_node("/root/Game/Default").zoom_step)
