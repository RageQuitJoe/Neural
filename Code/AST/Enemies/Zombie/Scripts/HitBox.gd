extends Area2D

onready var kickback = get_node("/root/Game/Default").kickback * 0.25

func hitbox_timer():
	$HitBoxTimer.set_wait_time(0.05)
	$HitBoxTimer.start()

func _on_HitBoxTimer_timeout():
	kickback = get_node("/root/Game/Default").kickback * 0.25
	get_parent().position -= get_node("../Follow").velocity * kickback
	if get_parent().battery <= 0.9:
		get_parent().queue_free()
	else:
		get_parent().battery -= (get_node("/root/Game/Default").damage*0.05)

func _on_HitBox_area_entered(_body):
	get_parent().detect = true
	hitbox_timer()
	
func _on_HitBox_area_exited(_area):
	if get_parent().battery <= 0:
		get_parent().queue_free()
		get_node("../../").remzom -= 1
	else:
		get_parent().battery -= (get_node("/root/Game/Default").damage*0.05)
	$HitBoxTimer.stop()
