#/Game/HUD
#Instanced from /Game.new_Game()
extends Node2D
onready var player = get_node("/root/Game/Player")
onready var hud = get_node("/root/Game/HUD/CanvasLayer/Modulate")
onready var tint = get_node("/root/Game/HUD/CanvasLayer/Tint")
onready var readout = get_node("/root/Game/HUD/CanvasLayer/Readout")
var hud_on = false
var time

func _ready():
	timer()

func timer():
	$HudTimer.set_wait_time(0.05)
	$HudTimer.start()

func _on_HudTimer_timeout():
	#### Modulate HUD ####
	var battery_color = get_node("/root/Game/Player/Sprites").battery_color

	hud.modulate = battery_color
	hud.modulate.a = get_node("/root/Game/Default").hud_alpha
	tint.modulate = battery_color
	tint.modulate.a = get_node("/root/Game/Default").hud_tint
	readout.modulate = "262626"
	readout.modulate.a = 0.75

	#### Player POS ####
	get_node("/root/Game/HUD/CanvasLayer/Modulate/POS/POSx").set_text(str(int(player.position.x)))
	get_node("/root/Game/HUD/CanvasLayer/Modulate/POS/POSy").set_text(str(int(player.position.y)))

	#### Day ####
	var cdn = get_node("/root/Game/DayNightCycle").current_day_number
	get_node("/root/Game/HUD/CanvasLayer/Modulate/Time/Date").set_text("DAY: "+str(cdn))

	#### Time ####
	var cdh = get_node("/root/Game/DayNightCycle").current_day_hour
	var hour = int(cdh)
	var minute = int((cdh-hour)*60)
	get_node("/root/Game/HUD/CanvasLayer/Modulate/Time/Hour").set_text(str(hour))
	if minute < 10:
		get_node("/root/Game/HUD/CanvasLayer/Modulate/Time/Minute").set_text("0"+str(minute))
	else:
		get_node("/root/Game/HUD/CanvasLayer/Modulate/Time/Minute").set_text(str(minute))

	#### Battery ####
	if hud_on == true:
		var bc = get_node("/root/Game/Player/Battery").battery_capacity
		var bu = get_node("/root/Game/Player/Battery").battery_used
		var dr = get_node("/root/Game/Player/Battery").battery_drain
		#var sp = get_node("/root/Game/Player/Movement").speed
	
		if dr < 999.95:
			get_node("/root/Game/HUD/CanvasLayer/Modulate/Battery/Drain").set_text("D:"+str(stepify(dr,0.1))+"W")
		if dr > 999.94 and dr < 999999.95:
			get_node("/root/Game/HUD/CanvasLayer/Modulate/Battery/Drain").set_text("D:"+str(stepify(dr*0.001,0.1))+"KW")
		if dr > 999999.94 and dr < 999999999.95:
			get_node("/root/Game/HUD/CanvasLayer/Modulate/Battery/Drain").set_text("D:"+str(stepify(dr*0.000001,0.1))+"MW")
		if dr > 999999999.94:
			get_node("/root/Game/HUD/CanvasLayer/Modulate/Battery/Drain").set_text("D:"+str(stepify(dr*0.000000001,0.1))+"GW")
	
		if bu < 999.94:
			get_node("/root/Game/HUD/CanvasLayer/Modulate/Battery/WHUse").set_text("C:"+str(stepify(bu,0.1))+"WH")
		if bu > 999.94 and bu < 999999.95:
			get_node("/root/Game/HUD/CanvasLayer/Modulate/Battery/WHUse").set_text("C:"+str(stepify(bu*0.001,0.1))+"KWH")
		if bu > 999999.94 and bu < 999999999.95:
			get_node("/root/Game/HUD/CanvasLayer/Modulate/Battery/WHUse").set_text("C:"+str(stepify(bu*0.000001,0.1))+"MWH")
		if bu > 999999999.94:
			get_node("/root/Game/HUD/CanvasLayer/Modulate/Battery/WHUse").set_text("C:"+str(stepify(bu*0.000000001,0.1))+"GWH")
	
		if bc < 999.94:
			get_node("/root/Game/HUD/CanvasLayer/Modulate/Battery/WHCap").set_text(str(stepify(bc,0.1))+"WH")
		if bc > 999.94 and bc < 999999.95:
			get_node("/root/Game/HUD/CanvasLayer/Modulate/Battery/WHCap").set_text(str(stepify(bc*0.001,0.1))+"KWH")
		if bc > 999999.94 and bc < 999999999.95:
			get_node("/root/Game/HUD/CanvasLayer/Modulate/Battery/WHCap").set_text(str(stepify(bc*0.000001,0.1))+"MWH")
		if bc > 999999999.94:
			get_node("/root/Game/HUD/CanvasLayer/Modulate/Battery/WHCap").set_text(str(stepify(bc*0.000000001,0.1))+"GWH")
	
	
