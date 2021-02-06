#/Game/Player/Battery
#Node of /Game/Player
extends Node2D

var dead = false

onready var battery_capacity = get_node("/root/Game/Default").battery_capacity
onready var battery_used = get_node("/root/Game/Default").battery_used
onready var battery_drain = get_node("/root/Game/Default").battery_drain

var zero_sixty = {}

func _ready():
	for i in range (59):
		zero_sixty["z_60_"+str(i)] = true  

func drain(): #Drian battery every DNC minute
	if dead == true and battery_used > 0:
		dead = false
	if dead == false:
		if battery_used > 0:
			battery_used -= battery_drain/60
		if battery_used <=0:
			battery_used = 0
			dead = true

func _process(_delta): 
	var hour = int(get_node("/root/Game/DayNightCycle").current_day_hour)
	var minute = int((get_node("/root/Game/DayNightCycle").current_day_hour-hour)*60)

	for i in range (59):
		if minute == i:
			if zero_sixty["z_60_"+str(i)] == true:
				drain()
				zero_sixty["z_60_"+str(i)] = false

	if minute == 59:
		for i in range (59):
			zero_sixty["z_60_"+str(i)] = true  

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
		"battery_capacity" : battery_capacity,
		"battery_used" : battery_used,
		"battery_drain" : battery_drain,
		"zero_sixty" : zero_sixty,
		"dead" : dead,
	}
	return save_dict

