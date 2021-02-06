extends Node2D

var debug = false
var fps = false
var full = false
var test = false

func _ready():
	pass 

func _input(_event):
	#### Debug ####
	if Input.is_action_just_pressed("Debug"):
		if debug == false:
			get_node("/root/Game/HUD/CanvasLayer/Modulate/Debug").visible = true
			debug = true
			print("Debug:ON")
		else:
			get_node("/root/Game/HUD/CanvasLayer/Modulate/Debug").visible = false
			debug = false
			print("Debug:OFF")

	if Input.is_action_just_pressed("Debug Fullscreen") and full == false and debug == true:
			if OS.window_fullscreen == false:
				OS.window_fullscreen = true
				full = true
#	if Input.is_action_just_pressed("ui_cancel") and full == true and debug == true:
#			if OS.window_fullscreen == true:
#				OS.window_fullscreen = false
#				full = false

	if Input.is_action_just_pressed("Debug Reset") and debug == true:
		get_node("/root/Game").reset()
	if Input.is_action_just_pressed("Debug Print Tree") and debug == true:
		get_node("/root/Game").print_tree_pretty()
	if Input.is_action_just_pressed("Debug Clear Console") and debug == true:
		pass
	if Input.is_action_just_pressed("Debug Save") and debug == true:
		$SaveLoad.save_game()
	if Input.is_action_just_pressed("Debug Load") and debug == true:
		$SaveLoad.load_game()

func _process(_delta):
	if debug == true:
		get_node("/root/Game/HUD/CanvasLayer/Modulate/Debug/FPS").set_text("FPS: "+str(Engine.get_frames_per_second()))
		var dmg = get_node("/root/Game/Default").damage
		if dmg< 999.94:
			get_node("/root/Game/HUD/CanvasLayer/Modulate/Debug/DMG").set_text("DMG: "+str(stepify(dmg,0.1))+"W")
		if dmg> 999.94 and dmg< 999999.95:
			get_node("/root/Game/HUD/CanvasLayer/Modulate/Debug/DMG").set_text("DMG: "+str(stepify(dmg*0.001,0.1))+"KW")
		if dmg> 999999.94 and dmg< 999999999.95:
			get_node("/root/Game/HUD/CanvasLayer/Modulate/Debug/DMG").set_text("DMG: "+str(stepify(dmg*0.000001,0.1))+"MW")
		if dmg> 999999999.94:
			get_node("/root/Game/HUD/CanvasLayer/Modulate/Debug/DMG").set_text("DMG: "+str(stepify(dmg*0.000000001,0.1))+"GW")
