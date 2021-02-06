#/Game/WorldGen
#Instanced from /Game/
extends Node2D
onready var time
var wg_on = false

var chunk_size = 3072#1536 #Pixel zize of chunks
var chunk_pos = Vector2(0,0) #Position of the chunk the player is on.
var chunk_cord = Vector2(0,0) #Cordinate of the chunk the player is on.
var chunk_map = [] # List of cordinates with chunks on them.
var room_map = []  # List of cordinates with rooms on them.
var zombie_map = []

func _ready():
	timer()

func timer():
	$Timer.set_wait_time(1)
	$Timer.start()

func rngx():
	var rngx = RandomNumberGenerator.new()
	rngx.randomize()
	rngx = rngx.randi_range(-1500,1500)
	return rngx

func rngy():
	var rngy = RandomNumberGenerator.new()
	rngy.randomize()
	rngy = rngy.randi_range(-736,736) #(chunk size / 2) - (room size / 2)
	return rngy

func chunk_gen():
	#### Position 9 Chunks #### 
	var C = Vector2(0,0)
	var N = Vector2(0,-(chunk_size))
	var E = Vector2(-(chunk_size), 0)
	var W = Vector2(chunk_size,0)
	var S = Vector2(0,chunk_size)
	var NE = Vector2(-(chunk_size),-(chunk_size))
	var NW = Vector2(chunk_size,-(chunk_size))
	var SE = Vector2(-(chunk_size), chunk_size)
	var SW = Vector2(chunk_size,chunk_size)
	var NESW = [C,N,E,S,W,NE,NW,SE,SW]

	##### Generate 9 Chunks ####
	for i in range(9):
		var NESWcord = (chunk_pos + NESW[i]) / chunk_size #NESW position converted to cordinates 
		var chunk_check = chunk_map.has(NESWcord) #Check if chunk coordinates are in chunk map 
		if chunk_check == false: #chunk coordinate not in chunk map
			var inst_chunk = load("res://AST/Ground/Ground.tscn").instance()
			chunk_map.append(NESWcord)
			inst_chunk.position = chunk_pos+Vector2(NESW[i]) #Position instanced chunk.
			add_child(inst_chunk)

	#### Generate Random Rooms ####
	var rgen_num = 4 #number of times room is generated per chunk
	for x in range(rgen_num):	
		for i in range(9):
			var NESWcord = (chunk_pos + NESW[i]) / chunk_size #NESW position converted to cordinates
			var chunk_check = room_map.has(NESWcord) #Check if chunk coordinates are in chunk map 
			if chunk_check == false: #chunk coordinate not in chunk map
				var rngx = int(rngx()/16) * 16
				var rngy = int(rngy()/16) * 16
				var inst_room = load("res://AST/Buildings/Basic/Rooms/BR4.tscn").instance()
				inst_room.position =  chunk_pos+Vector2(NESW[i])+Vector2(rngx,rngy) #Position instanced chunk.
				inst_room.placed = true
				add_child(inst_room)
				
				if x == rgen_num-1:
					room_map.append(NESWcord)

	#### Generate Random Zombies ####
	var zgen_num = 1 #number zombie generators generated per chunk
	for x in range(zgen_num):	
		for i in range(9):
			var NESWcord = (chunk_pos + NESW[i]) / chunk_size #NESW position converted to cordinates
			var chunk_check = zombie_map.has(NESWcord) #Check if chunk coordinates are in chunk map 
			if chunk_check == false: #chunk coordinate not in chunk map
				var rngx = int(rngx()/16) * 16
				var rngy = int(rngy()/16) * 16
				var inst_zgen = load("res://GEN/ZombieGen/ZombieGen.tscn").instance()
				inst_zgen.position =  chunk_pos+Vector2(NESW[i])+Vector2(rngx,rngy) #Position instanced chunk.
				add_child(inst_zgen)
				
				if x == zgen_num-1:
					zombie_map.append(NESWcord)

func _on_Timer_timeout():
	var playerpos = get_node("/root/Game/Player").position #Retrive player position.
	if wg_on == true:
		wg_on = false
		add_child(load("res://Gen/TileGen.tscn").instance())
		chunk_gen()

	if playerpos.y <= chunk_pos.y - (chunk_size / 2): #Generate new chunk when player crosses half way through nothern part of chunk.
		chunk_pos = chunk_pos - Vector2(0,chunk_size) #Update chunk position to new chunk position.
		chunk_cord = chunk_pos / chunk_size #Update chunk cordinates to new chunk cordinates.
		chunk_gen() #Generate new chunk.
	if playerpos.x >= chunk_pos.x + (chunk_size / 2): #Generate new chunk when player crosses half way through eastern part of chunk.
		chunk_pos = chunk_pos + Vector2(chunk_size,0)
		chunk_cord = chunk_pos / chunk_size
		chunk_gen()
	if playerpos.y >= chunk_pos.y + (chunk_size / 2): #Generate new chunk when player crosses half way through southern part of chunk.
		chunk_pos = chunk_pos + Vector2(0,chunk_size)
		chunk_cord = chunk_pos / chunk_size
		chunk_gen()
	if playerpos.x <= chunk_pos.x - (chunk_size / 2): #Generate new chunk when player crosses half way through western part of chunk.
		chunk_pos = chunk_pos - Vector2(chunk_size,0)
		chunk_cord = chunk_pos / chunk_size
		chunk_gen()

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
		"wg_on" : wg_on,
		"chunk_pos_x" : chunk_pos.x,
		"chunk_pos_y" : chunk_pos.y,
		"chunk_map" : chunk_map,
		"room_map" : room_map,
	}
	return save_dict

