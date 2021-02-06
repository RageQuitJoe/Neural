extends KinematicBody2D

var detect = false #if detect, folow player
var anmstate = "dw"
var battery = 100*1000 #10KWH

func _ready():
	add_collision_exception_with(self) #prevent suicide

func _process(_delta):
		if battery < 999.94:
			$Battery.set_text(str(stepify(battery,0.1))+"WH")
		if battery > 999.94 and battery < 999999.95:
			$Battery.set_text(str(stepify(battery*0.001,0.1))+"KWH")
		if battery > 999999.94 and battery < 999999999.95:
			$Battery.set_text(str(stepify(battery*0.000001,0.1))+"MWH")
		if battery > 999999999.94:
			$Battery.set_text(str(stepify(battery*0.000000001,0.1))+"GWH")

#### Save ####
var free = true #Used in SaveLoad
func save():
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"name" : name,
		"pos_x" : position.x, # Vector2 is not supported by JSON
		"pos_y" : position.y,
		"free" : free,
		"detect" : detect,
		"anmstate" : anmstate,
		"battery" : battery,
	}
	return save_dict
