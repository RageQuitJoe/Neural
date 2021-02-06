#/Game/WorldGen/TileGen
#Instanced from /Game/WorldGen/TileGen
extends Node2D

var loaded_tile 
var tile_height #Set in menu
var tile_path #Set in menu
var removedf = false #Used to clear WorldGen DoubleFree check.
func _ready():
	pass

func gen_tile():
	var plypos = get_node("/root/Game/Player").position
	var p_pos_convx = int(plypos.x/16) * 16
	var p_pos_convy = int(plypos.y/16) * 16
	var p_pos_conv = Vector2(p_pos_convx,p_pos_convy)
	var load_tile = load(tile_path).instance()
	var th_adjust = (tile_height/2)+32
	load_tile.position = p_pos_conv + Vector2(0,-(th_adjust))
	load_tile.removedf = removedf
	add_child(load_tile)
