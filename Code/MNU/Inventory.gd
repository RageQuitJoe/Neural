#Game/HUD/Inventory
#Instanced from /Game/Player/PlayerInput 
extends Node2D

var cord = Vector2(0,0)

func _ready():
	set_menu()
	timer()

func timer():
	$Timer.set_wait_time(0.05)
	$Timer.start()

func _on_Timer_timeout():
	
	$Modulate.modulate = get_node("/root/Game/Player/Sprites").battery_color
	$Modulate.modulate.a = get_node("/root/Game/Default").hud_alpha
	$Modulate/Carousel/Selector.modulate.a = get_node("/root/Game/Default").selector_alpha
	$NoModulate.modulate.a = get_node("/root/Game/Default").hud_alpha*1.5

func _input(_event):
	if Input.is_action_just_pressed("Menu"):
		call_deferred("free")#Close menu
		get_tree().set_input_as_handled() 
		get_node("/root/Game/Default").player_inputon() #Re-enable player input.
	if Input.is_action_just_pressed("Menu Left"):
		get_tree().set_input_as_handled() 
		pass
	if Input.is_action_just_pressed("Menu Right"):
		get_tree().set_input_as_handled() 
		pass
	if Input.is_action_just_pressed("Accept"):
		get_tree().set_input_as_handled() 
		accept()
	if Input.is_action_just_pressed("DUp"):
		get_tree().set_input_as_handled() 
		if cord.y >= -1: #Up limit.
			cord.y -= 1
			$Modulate/Carousel/Selector.position = $Modulate/Carousel/Selector.position + Vector2(0, -(32))
			update()
	elif Input.is_action_just_pressed("DDown"): 
		get_tree().set_input_as_handled() 
		if cord.y <= 1: #Down limit.
			cord.y += 1
			$Modulate/Carousel/Selector.position = $Modulate/Carousel/Selector.position +Vector2(0, 32)
			update()
	elif Input.is_action_just_pressed("DLeft"): 
		get_tree().set_input_as_handled() 
		if cord.x >= -1: #Left Limit.
			cord.x -= 1
			$Modulate/Carousel/Selector.position = $Modulate/Carousel/Selector.position + Vector2(-(32), 0)
			update()
	elif Input.is_action_just_pressed("DRight"): 
		get_tree().set_input_as_handled() 
		if cord.x <= 1: #Right limit.
			cord.x += 1
			$Modulate/Carousel/Selector.position = $Modulate/Carousel/Selector.position + Vector2(32, 0)
			update()

#Row A
var rn2_n2 = "res://MNU/EmptyD.png"
var rn1_n2 = "res://MNU/EmptyD.png"
var r0_n2 = "res://MNU/EmptyD.png"
var r1_n2 = "res://MNU/EmptyD.png"
var r2_n2 = "res://MNU/EmptyD.png"
#Row B
var rn2_n1 = "res://MNU/EmptyD.png"
var rn1_n1 = "res://MNU/EmptyD.png"
var r0_n1 = "res://MNU/EmptyD.png"
var r1_n1 = "res://MNU/EmptyD.png"
var r2_n1 = "res://MNU/EmptyD.png"
#Row C
var rn2_0 = "res://AST/Buildings/Basic/Rooms/BR4.png"
var rn1_0 = "res://MNU/EmptyD.png"
var r0_0 = "res://MNU/EmptyD.png"
var r1_0 = "res://MNU/EmptyD.png"
var r2_0 = "res://MNU/EmptyD.png"
#Row D
var rn2_1 = "res://MNU/EmptyD.png"
var rn1_1 = "res://MNU/EmptyD.png"
var r0_1 = "res://MNU/EmptyD.png"
var r1_1 = "res://MNU/EmptyD.png"
var r2_1 = "res://MNU/EmptyD.png"
#Row E
var rn2_2 = "res://MNU/EmptyD.png"
var rn1_2 = "res://MNU/EmptyD.png"
var r0_2 = "res://MNU/EmptyD.png"
var r1_2 = "res://MNU/EmptyD.png"
var r2_2 = "res://MNU/EmptyD.png"

func accept():
	#Row A
	if cord == Vector2(-2,-2):
		if OS.window_fullscreen == false:
			OS.window_fullscreen = true
		else:
			OS.window_fullscreen = false
	if cord == Vector2(-1,-2):
		call_deferred("free")#Close menu
		get_node("/root/Game/Default").player_inputon() #Re-enable player input.
		get_node("/root/Game/").add_child(load("res://SAV/LoadScreen.tscn").instance()) #Load Screen
		get_node("/root/Game/LoadScreen").load_on = true
	if cord == Vector2(0,-2):
		pass
	if cord == Vector2(1,-2):
		call_deferred("free")#Close menu
		get_node("/root/Game/Default").player_inputon() #Re-enable player input.
		get_node("/root/Game/SaveLoad").save_game()
	if cord == Vector2(2,-2):
			get_tree().quit() #Quit Game
	#Row B
	if cord == Vector2(-2,-1):
		pass
	if cord == Vector2(-1,-1):
		pass
	if cord == Vector2(0,-1):
		pass
	if cord == Vector2(1,-1):
		pass
	if cord == Vector2(2,-1):
		pass
	#Row C
	if cord == Vector2(-2,0):
		call_deferred("free")#Close menu
		#Set tile path in TileGen
		get_node("/root/Game/WorldGen/TileGen").tile_path = "res://AST/Buildings/Basic/Rooms/BR4.tscn"
		#Set tile height in TileGen
		get_node("/root/Game/WorldGen/TileGen").tile_height = 160
		get_node("/root/Game/WorldGen/TileGen").removedf = true ##Used to clear WorldGen DoubleFree check.
		#Start Tile Gen
		get_node("/root/Game/WorldGen/TileGen").gen_tile()
	if cord == Vector2(-1,0):
		pass
	if cord == Vector2(0,0):
		pass
	if cord == Vector2(1,0):
		pass
	if cord == Vector2(2,0):
		pass
	#Row D
	if cord == Vector2(-2,1):
		pass
	if cord == Vector2(-1,1):
		pass
	if cord == Vector2(0,1):
		pass
	if cord == Vector2(1,1):
		pass
	if cord == Vector2(2,1):
		pass
	#Row E
	if cord == Vector2(-2,2):
		pass
	if cord == Vector2(-1,2):
		pass
	if cord == Vector2(0,2):
		pass
	if cord == Vector2(1,2):
		pass
	if cord == Vector2(2,2):
		pass

func set_menu():
	$NoModulate/Selected.texture = load(r0_0)
	#Row A
	$NoModulate/Carousel/A/A1B.texture = load(rn2_n2)
	$NoModulate/Carousel/A/A2B.texture = load(rn1_n2)
	$NoModulate/Carousel/A/A3B.texture = load(r0_n2)
	$NoModulate/Carousel/A/A4B.texture = load(r1_n2)
	$NoModulate/Carousel/A/A5B.texture = load(r2_n2)
	#Row B
	$NoModulate/Carousel/B/B1B.texture = load(rn2_n1)
	$NoModulate/Carousel/B/B2B.texture = load(rn1_n1)
	$NoModulate/Carousel/B/B3B.texture = load(r0_n1)
	$NoModulate/Carousel/B/B4B.texture = load(r1_n1)
	$NoModulate/Carousel/B/B5B.texture = load(r2_n1)
	#Row C
	$NoModulate/Carousel/C/C1B.texture = load(rn2_0)
	$NoModulate/Carousel/C/C2B.texture = load(rn1_0)
	$NoModulate/Carousel/C/C3B.texture = load(r0_0)
	$NoModulate/Carousel/C/C4B.texture = load(r1_0)
	$NoModulate/Carousel/C/C5B.texture = load(r2_0)
	#Row D
	$NoModulate/Carousel/D/D1B.texture = load(rn2_1)
	$NoModulate/Carousel/D/D2B.texture = load(rn1_1)
	$NoModulate/Carousel/D/D3B.texture = load(r0_1)
	$NoModulate/Carousel/D/D4B.texture = load(r1_1)
	$NoModulate/Carousel/D/D5B.texture = load(r2_1)
	#Row E
	$NoModulate/Carousel/E/E1B.texture = load(rn2_2)
	$NoModulate/Carousel/E/E2B.texture = load(rn1_2)
	$NoModulate/Carousel/E/E3B.texture = load(r0_2)
	$NoModulate/Carousel/E/E4B.texture = load(r1_2)
	$NoModulate/Carousel/E/E5B.texture = load(r2_2)

func update():
	#Row A
	if cord == Vector2(-2,-2):
		$NoModulate/Selected.texture = load(rn2_n2)
	if cord == Vector2(-1,-2):
		$NoModulate/Selected.texture = load(rn1_n2)
	if cord == Vector2(0,-2):
		$NoModulate/Selected.texture = load(r0_n2)
	if cord == Vector2(1,-2):
		$NoModulate/Selected.texture = load(r1_n2)
	if cord == Vector2(2,-2):
		$NoModulate/Selected.texture = load(r2_n2)
	#Row B
	if cord == Vector2(-2,-1):
		$NoModulate/Selected.texture = load(rn2_n1)
	if cord == Vector2(-1,-1):
		$NoModulate/Selected.texture = load(rn1_n1)
	if cord == Vector2(0,-1):
		$NoModulate/Selected.texture = load(r0_n1)
	if cord == Vector2(1,-1):
		$NoModulate/Selected.texture = load(r1_n1)
	if cord == Vector2(2,-1):
		$NoModulate/Selected.texture = load(r2_n1)
	#Row C
	if cord == Vector2(-2,0):
		$NoModulate/Selected.texture = load(rn2_0)
	if cord == Vector2(-1,0):
		$NoModulate/Selected.texture = load(rn1_0)
	if cord == Vector2(0,0):
		$NoModulate/Selected.texture = load(r0_0)
	if cord == Vector2(1,0):
		$NoModulate/Selected.texture = load(r1_0)
	if cord == Vector2(2,0):
		$NoModulate/Selected.texture = load(r2_0)
	#Row D
	if cord == Vector2(-2,1):
		$NoModulate/Selected.texture = load(rn2_1)
	if cord == Vector2(-1,1):
		$NoModulate/Selected.texture = load(rn1_1)
	if cord == Vector2(0,1):
		$NoModulate/Selected.texture = load(r0_1)
	if cord == Vector2(1,1):
		$NoModulate/Selected.texture = load(r1_1)
	if cord == Vector2(2,1):
		$NoModulate/Selected.texture = load(r2_1)
	#Row E
	if cord == Vector2(-2,2):
		$NoModulate/Selected.texture = load(rn2_2)
	if cord == Vector2(-1,2):
		$NoModulate/Selected.texture = load(rn1_2)
	if cord == Vector2(0,2):
		$NoModulate/Selected.texture = load(r0_2)
	if cord == Vector2(1,2):
		$NoModulate/Selected.texture = load(r1_2)
	if cord == Vector2(2,2):
		$NoModulate/Selected.texture = load(r2_2)
