#/Game/SaveLoad
#Instanced from /Game
extends Node2D

var save_name = "game1"
var save_file = "user://"+save_name+".sav"

func _ready():
	pass 

func save_game():
	#Make new save file
	var save_game = File.new()
	save_game.open(save_file, File.WRITE)

	var save_nodes = get_tree().get_nodes_in_group("Save")
	for node in save_nodes:
		# Check the node has a save function
		if !node.has_method("save"):
			print("node '%s' is missing a save() function, skipped" % node.name)
			continue
		# Call the node's save function
		var node_data = node.call("save")
		# Store the save dictionary as a new line in the save file
		save_game.store_line(to_json(node_data))

	var save_nodesx = get_tree().get_nodes_in_group("SaveFree")
	for node in save_nodesx:
		# Check the node has a save function
		if !node.has_method("save"):
			print("node '%s' is missing a save() function, skipped" % node.name)
			continue
		# Call the node's save function
		var node_data = node.call("save")
		# Store the save dictionary as a new line in the save file
		save_game.store_line(to_json(node_data))
	save_game.close()
	print("Game Saved")

func load_game():
	var save_game = File.new()
	save_game.open(save_file, File.READ)
	var node_data = parse_json(save_game.get_line())

	if not save_game.file_exists(save_file):
		return # Error! We don't have a save to load.

	var savefree_nodes = get_tree().get_nodes_in_group("SaveFree")
	for i in savefree_nodes:
		i.call_deferred("free")

	var save_nodes = get_tree().get_nodes_in_group("Save")
	for i in save_nodes:
		if i.name == "Player":
			#print(i.name)
			load_player()
			continue
		if i.name == "DayNightCycle":
			#print(i.name)
			load_dnc()
			continue
		if i.name == "WorldGen":
			#print(i.name)
			load_worldgen()
			continue

	while save_game.get_position() < save_game.get_len():
		node_data = parse_json(save_game.get_line())
		
		if node_data["free"] == true:
			var new_object = load(node_data["filename"]).instance()
			get_node(node_data["parent"]).call_deferred("add_child",new_object)
			new_object.position = Vector2(node_data["pos_x"], node_data["pos_y"])
			new_object.placed = node_data["placed"]
			for i in node_data.keys():
				if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y" or i == "name":
					continue
				new_object.set(i, node_data[i])
		if node_data["free"] == false and node_data["name"] != "WorldGen" and node_data["name"] != "DayNightCycle" and node_data["name"] != "Player":
			for i in node_data.keys():
				if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y" or i == "name":
					continue
				get_node(node_data["parent"]+"/"+node_data["name"]).set(i, node_data[i])

	save_game.close()
	print("Game Loaded")

func load_player():
	var save_game = File.new()
	save_game.open(save_file, File.READ)
	var node_data = parse_json(save_game.get_line())
	while node_data["name"] != "Player":
		node_data = parse_json(save_game.get_line())
	for i in node_data.keys():
		if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y" or i == "name":
			continue
		get_node("/root/Game/Player").set(i, node_data[i])
	get_node("/root/Game/Player/Camera").zoom = get_node("/root/Game/Default").start_zoom
	get_node("/root/Game/Player").position = Vector2(node_data["pos_x"], node_data["pos_y"])
	save_game.close()

func load_dnc():
	var save_game = File.new()
	save_game.open(save_file, File.READ)
	var node_data = parse_json(save_game.get_line())
	while node_data["name"] != "DayNightCycle":
		node_data = parse_json(save_game.get_line())
	for i in node_data.keys():
		if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y" or i == "name":
			continue
		get_node("/root/Game/DayNightCycle").set(i, node_data[i])
	get_node("/root/Game/DayNightCycle").load_cycle(node_data["cycle"])
	save_game.close()

func load_worldgen():
	var save_game = File.new()
	save_game.open(save_file, File.READ)
	var node_data = parse_json(save_game.get_line())
	while node_data["name"] != "WorldGen":
		node_data = parse_json(save_game.get_line())
	get_node("/root/Game/WorldGen").chunk_pos = Vector2(node_data["chunk_pos_x"], node_data["chunk_pos_y"])
	get_node("/root/Game/WorldGen").chunk_map = node_data["chunk_map"]
	get_node("/root/Game/WorldGen").room_map += node_data["room_map"]
	save_game.close()
