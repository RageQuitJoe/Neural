#/Game/Player/Movement
#Node of /Game/Player
extends Node2D

onready var anmply = get_node("../Anmimation")
onready var anmstat = "dw"
onready var speed = get_node("/root/Game/Default").player_def_speed
var inputdir = Vector2.ZERO

var move_on = false
var run = false
var sneak = false
var fire = false

func _ready():
	anmply.set_speed_scale(1.5)
	set_process_input(true)

func _input(event):
	if move_on ==true:
		if Input.is_action_pressed("Up"): #UP
			anmply.play("mv_up");
			anmstat = "up"
		if Input.is_action_pressed("Down"): #DOWN
			anmply.play("mv_dw");
			anmstat = "dw"
		if Input.is_action_pressed("Left"): #LEFT
			if Input.is_action_pressed("Up"):
				anmply.play("mv_up");
				anmstat = "up"
			elif Input.is_action_pressed("Down"):
				anmply.play("mv_dw");
				anmstat = "dw"
			else:
				anmply.play("mv_lt");
				anmstat = "lt"
		if Input.is_action_pressed("Right"): #Right
			if Input.is_action_pressed("Up"):
				anmply.play("mv_up");
				anmstat = "up"
			elif Input.is_action_pressed("Down"):
				anmply.play("mv_dw");
				anmstat = "dw"
			else:
				anmply.play("mv_rt");
				anmstat = "rt"
		#### Run ####
		if Input.is_action_pressed("Run"): #RUN
			if speed == get_node("/root/Game/Default").player_def_speed:
				run = true
				speed = get_node("/root/Game/Default").player_max_speed
				get_node("../Battery").battery_drain += get_node("/root/Game/Default").run_drain
				anmply.set_speed_scale(get_node("/root/Game/Default").player_max_speed*0.01)
		if event.is_action_released("Run"): #RUN
			if speed == get_node("/root/Game/Default").player_max_speed:
				run = false
				speed = get_node("/root/Game/Default").player_def_speed
				get_node("../Battery").battery_drain -= get_node("/root/Game/Default").run_drain
				anmply.set_speed_scale(get_node("/root/Game/Default").player_def_speed*0.01)
		#### Sneak ####
		if Input.is_action_pressed("Sneak"): #Sneak
			if speed == get_node("/root/Game/Default").player_def_speed:
				sneak = true
				speed = get_node("/root/Game/Default").player_snk_speed
				anmply.set_speed_scale(get_node("/root/Game/Default").player_snk_speed*0.01)
		if event.is_action_released("Sneak"): #Sneak
			if speed == get_node("/root/Game/Default").player_snk_speed:
				sneak = false
				speed = get_node("/root/Game/Default").player_def_speed
				anmply.set_speed_scale(get_node("/root/Game/Default").player_def_speed*0.01)

func _process(_delta):
	if move_on == true:
		inputdir.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
		inputdir.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")

		var velocity = inputdir * speed
		get_parent().move_and_slide(velocity)

		if velocity == Vector2.ZERO:
			if anmstat == "up":
				anmply.play("id_up");
			if anmstat == "dw":
				anmply.play("id_dw");
			if anmstat == "lt":
				anmply.play("id_lt");
			if anmstat == "rt":
				anmply.play("id_rt");

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
		"anmstat" : anmstat,
	}
	return save_dict
