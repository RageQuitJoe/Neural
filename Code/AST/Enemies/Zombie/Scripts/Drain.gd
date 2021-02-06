extends Node2D

var drainnear = false
var drainfar = false
var nearpd = 1 # Near % drained
var farpd = 0.25 # Far % drained

func _on_DrainNear_area_entered(_area): #Drain 10% of players battery per game min
	drainnear = true
	draintimer()
	get_node("/root/Game/Player/Battery").battery_drain += get_node("/root/Game/Player/Battery").battery_capacity*nearpd
func _on_DrainNear_area_exited(_area):
	drainnear =false
	$DrainTimer.stop()
	get_node("/root/Game/Player/Battery").battery_drain -= get_node("/root/Game/Player/Battery").battery_capacity*nearpd
func _on_DrainFar_area_entered(_area): #Drain 1% of players battery per game min
	get_node("/root/Game/Player/Battery").battery_drain += get_node("/root/Game/Player/Battery").battery_capacity*farpd
	drainfar = true
	draintimer()
func _on_DrainFar_area_exited(_area):
	drainnear = false
	$DrainTimer.stop()
	get_node("/root/Game/Player/Battery").battery_drain -= get_node("/root/Game/Player/Battery").battery_capacity*farpd

func draintimer():
	$DrainTimer.set_wait_time(1)
	$DrainTimer.start()

func _on_DrainTimer_timeout():
	if drainnear == true:
		get_parent().battery += (get_node("/root/Game/Player/Battery").battery_capacity * nearpd)/60
	if drainfar == true:
		get_parent().battery += (get_node("/root/Game/Player/Battery").battery_capacity * farpd)/60
