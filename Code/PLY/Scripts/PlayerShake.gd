extends Area2D


#### Shake Camera####
func _on_Shake_area_entered(_area):
	timer()
	
func _on_Shake_area_exited(_area):
	$Timer.stop()

func timer():
	$Timer.set_wait_time(0.05)
	$Timer.start()

func _on_Timer_timeout():
	get_node("../Camera").add_trauma(0.05)
