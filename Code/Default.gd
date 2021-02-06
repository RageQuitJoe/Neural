#/Game/Defaults
extends Node2D

func _ready():
	pass

#### HUD ####
export var hud_alpha = 0.5
export var hud_tint = 0.01
export var selector_alpha = 1

#### Enimies ####
var kickback = 1
var damage = 0

#### Player ####
func player_inputoff(): # get_node("/root/Game/Default").player_inputoff()
	get_node("/root/Game/Player/PlayerInput").call_deferred("free")
func player_inputon(): # get_node("/root/Game/Default").player_inputon() #Re-enable player input.
	get_node("/root/Game/Player").call_deferred("add_child",load("res://PLY/Scripts/PlayerInput.tscn").instance())
## Movment ##
var player_snk_speed = 75
var player_def_speed = 150 
var player_max_speed = 250 
## Camera ##
export var zoom_step = 0.25
export var min_zoom = 0.25
export var max_zoom = 10
export var start_zoom = Vector2(0.5,0.5)
## Drain ##
export var mainlight_drain = 1*1000 #KWH
export var run_drain = 5*1000 #KWH
## Battery ##
func reset_playbat():
	get_node("/root/Game/Player/Battery").battery_capacity = battery_capacity
	get_node("/root/Game/Player/Battery").battery_used = battery_used
	get_node("/root/Game/Player/Battery").battery_drain = battery_drain
var battery_capacity = float(100*1000) #KWH
var battery_used = float(100*1000) #KWH
var life_support = 1*1000 #KWH
var battery_drain = float(life_support) #KW

