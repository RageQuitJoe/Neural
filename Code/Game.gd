#/Game
#Main Scene
extends Node2D

func _ready():
	OS.set_window_position( OS.get_screen_size()*0.5 - OS.get_window_size()*0.5) #Center window on screen
#	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN) #Hide mouse,
	add_child(load("res://SAV/SaveLoad.tscn").instance()) #Save and Load functions
	add_child(load("res://PLY/Player.tscn").instance()) #Player
	add_child(load("res://DNC/DayNightCycle.tscn").instance()) #Day Night Cycle
	add_child(load("res://GEN/WorldGen.tscn").instance())
	add_child(load("res://HUD/HUD.tscn").instance()) #HUD
	get_node("/root/Game/HUD/CanvasLayer").add_child(load("res://MNU/MainMenu/MainMenu.tscn").instance()) # Main Menu

func reset():
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
