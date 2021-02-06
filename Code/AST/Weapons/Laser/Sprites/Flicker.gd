extends Timer
var switch = true

func timer():
	set_wait_time(0.33)
	start()

func _on_Color_timeout():
	if get_parent().modulate.a < 0.85:
		get_parent().modulate.a += 0.1
	else:
		get_parent().laser_on = true
		
		if switch == true:
			switch = false
			get_parent().modulate.a = 1
		else:
			switch = true
			get_parent().modulate.a = 0.85

