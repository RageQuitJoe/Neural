#Game/HUD/MainMenu
#Instanced from /Game
extends Node2D

var cord = Vector2(0,0)

func _ready():
	set_menu()
	$Modulate/Menu.modulate = get_node("/root/Game/Player/Sprites").battery_color
	$Modulate/Menu.modulate.a = get_node("/root/Game/Default").hud_alpha
	$Modulate/Carousel/Menu/Options.modulate.a = get_node("/root/Game/Default").hud_alpha
	$Modulate/Carousel/Menu/Load.modulate.a = get_node("/root/Game/Default").hud_alpha
	$Modulate/Carousel/Menu/Donate.modulate = get_node("/root/Game/Player/Sprites").battery_color
	$Modulate/Carousel/Menu/Donate.modulate.a = get_node("/root/Game/Default").hud_alpha
	$Modulate/Carousel/Menu/New.modulate.a = get_node("/root/Game/Default").hud_alpha
	$Modulate/Carousel/Menu/Credits.modulate.a = get_node("/root/Game/Default").hud_alpha
	$Modulate/Copy.modulate.a = get_node("/root/Game/Default").hud_alpha

func mod_update():
	if cord == Vector2(-2,0): #Options
		$Modulate/Menu.set_text("OPTIONS")
		$Modulate/Carousel/Menu/Options.modulate = get_node("/root/Game/Player/Sprites").battery_color
		$Modulate/Carousel/Menu/Options.modulate.a = get_node("/root/Game/Default").hud_alpha
		$Modulate/Carousel/Menu/Load.modulate = "ffffff"
		$Modulate/Carousel/Menu/Load.modulate.a = get_node("/root/Game/Default").hud_alpha
	if cord == Vector2(-1,0): #Load
		$Modulate/Menu.set_text("LOAD")
		$Modulate/Carousel/Menu/Options.modulate = "ffffff"
		$Modulate/Carousel/Menu/Options.modulate.a = get_node("/root/Game/Default").hud_alpha
		$Modulate/Carousel/Menu/Load.modulate = get_node("/root/Game/Player/Sprites").battery_color
		$Modulate/Carousel/Menu/Load.modulate.a = get_node("/root/Game/Default").hud_alpha
		$Modulate/Carousel/Menu/Donate.modulate = "ffffff"
		$Modulate/Carousel/Menu/Donate.modulate.a = get_node("/root/Game/Default").hud_alpha
	if cord == Vector2(0,0): #Donate
		$Modulate/Menu.set_text("DONATE")
		$Modulate/Carousel/Menu/Load.modulate = "ffffff"
		$Modulate/Carousel/Menu/Load.modulate.a = get_node("/root/Game/Default").hud_alpha
		$Modulate/Carousel/Menu/Donate.modulate = get_node("/root/Game/Player/Sprites").battery_color
		$Modulate/Carousel/Menu/Donate.modulate.a = get_node("/root/Game/Default").hud_alpha
		$Modulate/Carousel/Menu/New.modulate = "ffffff"
		$Modulate/Carousel/Menu/New.modulate.a = get_node("/root/Game/Default").hud_alpha
	if cord == Vector2(1,0): #New
		$Modulate/Menu.set_text("NEW")
		$Modulate/Carousel/Menu/Donate.modulate = "ffffff"
		$Modulate/Carousel/Menu/Donate.modulate.a = get_node("/root/Game/Default").hud_alpha
		$Modulate/Carousel/Menu/New.modulate = get_node("/root/Game/Player/Sprites").battery_color
		$Modulate/Carousel/Menu/New.modulate.a = get_node("/root/Game/Default").hud_alpha
		$Modulate/Carousel/Menu/Credits.modulate = "ffffff"
		$Modulate/Carousel/Menu/Credits.modulate.a = get_node("/root/Game/Default").hud_alpha
	if cord == Vector2(2,0): #Credits
		$Modulate/Menu.set_text("CREDITS")
		$Modulate/Carousel/Menu/New.modulate = "ffffff"
		$Modulate/Carousel/Menu/New.modulate.a = get_node("/root/Game/Default").hud_alpha
		$Modulate/Carousel/Menu/Credits.modulate = get_node("/root/Game/Player/Sprites").battery_color
		$Modulate/Carousel/Menu/Credits.modulate.a = get_node("/root/Game/Default").hud_alpha

func _input(_event):
	if Input.is_action_just_pressed("DLeft"): 
		get_tree().set_input_as_handled() 
		if cord.x >= -1: #Left Limit.
			cord.x -= 1
			mod_update()
			update()
	elif Input.is_action_just_pressed("DRight"):
		get_tree().set_input_as_handled()  
		if cord.x <= 1: #Right limit.
			cord.x += 1
			mod_update()
			update()
	elif Input.is_action_just_pressed("Accept"):
		get_tree().set_input_as_handled() 
		if cord == Vector2(-2,0): #Options
			pass
			#call_deferred("free") #Close menu
		if cord == Vector2(-1,0): #Load
			call_deferred("free") #Close menu
			get_node("/root/Game/HUD").hud_on = true
			get_node("/root/Game/DayNightCycle").dnc_on = true
			get_node("/root/Game/WorldGen").wg_on = true
			get_node("/root/Game/Player/Movement").move_on = true
			get_node("/root/Game/Default").player_inputon() #Re-enable player input.
			get_node("/root/Game/").add_child(load("res://SAV/LoadScreen.tscn").instance()) #Load Screen
			get_node("/root/Game/LoadScreen").load_on = true
		if cord == Vector2(0,0): #Donate
# warning-ignore:return_value_discarded
			OS.shell_open("https://github.com/RageQuitJoe/Game")
		if cord == Vector2(1,0): #New
			call_deferred("free") #Close menu
			get_node("/root/Game/HUD").hud_on = true
			get_node("/root/Game/DayNightCycle").dnc_on = true
			get_node("/root/Game/WorldGen").wg_on = true
			get_node("/root/Game/Player/Movement").move_on = true
			get_node("/root/Game/Default").player_inputon() #Re-enable player input.
			get_node("/root/Game/").add_child(load("res://SAV/LoadScreen.tscn").instance()) #Load Screen
		if cord == Vector2(2,0): #Credits
# warning-ignore:return_value_discarded
			OS.shell_open("https://github.com/RageQuitJoe/Neural/wiki/Attribution")

#Row C
var rn2_0 = "res://MNU/MainMenu/Options.png" #Options
var rn1_0 = "res://MNU/MainMenu/Load.png" #Load
var r0_0 = "res://MNU/MainMenu/Donate.png" #Donate
var r1_0 = "res://MNU/MainMenu/New.png" #New
var r2_0 = "res://MNU/MainMenu/Credits.png" #Credits

func set_menu():
	#Row C
	$Modulate/Carousel/Menu/Options.texture = load(rn2_0)
	$Modulate/Carousel/Menu/Load.texture = load(rn1_0)
	$Modulate/Carousel/Menu/Donate.texture = load(r0_0)
	$Modulate/Carousel/Menu/New.texture = load(r1_0)
	$Modulate/Carousel/Menu/Credits.texture = load(r2_0)
