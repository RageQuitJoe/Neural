#Game/Player/Options
#Instanced from PlayerInputs 
extends Node2D
onready var player = get_parent()
onready var mastercolor = get_parent().battery_color

var x_cord = 0
var y_cord = -1

func _ready():
	position = position + Vector2(0,-32) #Position inventory above player.
	modulate = mastercolor #Set menu color.
	modulate.a = player.battery_lvl/2 #Menu opacity based on battery level.
	
func _input(_event):
	if Input.is_action_just_pressed("Options"):
		call_deferred("free")#Close menu
		get_parent().call_deferred("add_child",load("res://PLY/PlayerInput.tscn").instance()) #Re-enable player inputs.
	if Input.is_action_just_pressed("Accept"):
		#    1     2     3     4     5
		#A:-2:-2 -1:-2  0:-2  1:-2  2:-2
		#B:-2:-1 -1:-1  0:-1  1:-1  2:-1
		#C:-2: 0 -1: 0  0: 0  1: 0  2: 0
		if x_cord == -2 and y_cord == -2:
			get_node("../../SaveLoad").save_game()
		if x_cord == 2 and y_cord == -2:
			get_node("../../SaveLoad").load_game()
		if x_cord == 0 and y_cord == 0:
			get_tree().quit() #Quit Game
		if x_cord == 0 and y_cord == -1:
			if OS.window_fullscreen == false:
				OS.window_fullscreen = true
			else:
				OS.window_fullscreen = false
	if Input.is_action_just_pressed("DUp"):
		if y_cord >= -1: #Up limit.
			y_cord -= 1
			$Selector.position = $Selector.position + Vector2(0, -(32))
	elif Input.is_action_just_pressed("DDown"): 
		if y_cord <= -1: #Down limit.
			y_cord += 1
			$Selector.position = $Selector.position +Vector2(0, 32)
	elif Input.is_action_just_pressed("DLeft"): 
		if x_cord >= -1: #Left Limit.
			x_cord -= 1
			$Selector.position = $Selector.position + Vector2(-(32), 0)
	elif Input.is_action_just_pressed("DRight"): 
		if x_cord <= 1: #Right limit.
			x_cord += 1
			$Selector.position = $Selector.position + Vector2(32, 0)

