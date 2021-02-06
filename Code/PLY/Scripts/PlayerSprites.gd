#/Game/Player/Sprites
#Node of /Game/Player
extends Node2D

#### Colors ####
var red = "ff7170"
var yel = "ffffa6"
var blu = "8297b2" 
var prp = "887c92"
var grn = "83a38b" 

var bred = "ff0000"
var byel = "ffff00"
var bblu = "007bff" 
var bprp = "8400ff"
var bgrn = "00ff37"

var blk = "262626"
var wht = "e6e6e6"
var gry1 = "bfbfbf"
var gry2 = "999999"
var gry3 = "737373"
var gry4 = "4d4d4d"

var helmet_color = grn
var screen_color = bgrn
var battery_color = bgrn
var suit_color = grn
var glove_color = bgrn
var boot_color = bgrn

func _ready():
	timer()

func timer():
	$Timer.set_wait_time(0.05)
	$Timer.start()

func _on_Timer_timeout():
	$Helmet.modulate = Color(helmet_color) 
	$Screen.modulate = Color(screen_color)
	$Suit.modulate = Color(suit_color)
	$Battery.modulate = Color(battery_color)
	$Glove.modulate = Color(glove_color)
	$Boot.modulate = Color(boot_color)

	$Screen.modulate.a = get_node("/root/Game/Default").hud_alpha
	$Battery.modulate.a = get_node("/root/Game/Default").hud_alpha
	$Glove.modulate.a = get_node("/root/Game/Default").hud_alpha 
	$Boot.modulate.a = get_node("/root/Game/Default").hud_alpha 

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
		"helmet_color" : helmet_color,
		"screen_color" : screen_color,
		"battery_color" : battery_color,
		"suit_color" : suit_color,
		"glove_color" : glove_color,
		"boot_color" : boot_color,
	}
	return save_dict
