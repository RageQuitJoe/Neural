extends Node2D

onready var playermov = get_node("/root/Game/Player/Movement")
onready var anm = get_node("../Anm")

func _on_Collision_area_entered(_area):
	get_parent().detect = false
	if get_parent().anmstate == "up":
		anm.play("ID_UP");
	if get_parent().anmstate == "dw":
		anm.play("ID_DW");
	if get_parent().anmstate == "lt":
		anm.play("ID_LT");
	if get_parent().anmstate == "rt":
		anm.play("ID_RT");
func _on_Collision_area_exited(_area):
	get_parent().detect = true
	if get_parent().anmstate == "up":
		anm.play("MV_UP");
	if get_parent().anmstate == "dw":
		anm.play("MV_DW");
	if get_parent().anmstate == "lt":
		anm.play("MV_LT");
	if get_parent().anmstate == "rt":
		anm.play("MV_RT");

func _on_Sight_area_entered(_area): #If not sneak detect
	get_parent().detect = true

func _on_HearWalk_area_entered(_area):
	if playermov.sneak == false:
		get_parent().detect = true

func _on_HearRun_area_entered(_area): #If running detect
	timer()
func _on_HearRun_area_exited(_area):
	if playermov.fire == false:
		get_parent().detect = false
		get_node("../Follow").velocity = Vector2.ZERO
		$Timer.stop()

func timer():
	$Timer.set_wait_time(0.25)
	$Timer.start()
func _on_Timer_timeout():
	if playermov.run == true: 
		get_parent().detect = true
	if playermov.fire == true:
		get_parent().detect = true
