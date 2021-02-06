extends Node2D
var load_on = false
func _ready():
	$CanvasLayer/LoadScreenTint.modulate = get_node("/root/Game/Player/Sprites").battery_color
	$CanvasLayer/LoadScreenTint.modulate.a = get_node("/root/Game/Default").hud_tint
	load_game()
	free_load()

func load_game():
	$Load.set_wait_time(0.5)
	$Load.start()
func free_load():
	$Unpause.set_wait_time(1)
	$Unpause.start()
func fadewait():
	$FadeWait.set_wait_time(1)
	$FadeWait.start()
func fade():
	$Fade.set_wait_time(0.05)
	$Fade.start()

func _on_Load_timeout():
	if load_on == true:
		get_node("/root/Game/SaveLoad").load_game()
		get_node("/root/Game").get_tree().paused = true
		$Load.stop()
	else:
		get_node("/root/Game").get_tree().paused = true
		$Load.stop()

func _on_Unpause_timeout():
	fadewait()
	get_node("/root/Game").get_tree().paused = false
	$Unpause.stop()

func _on_FadeWait_timeout():
	fade()
	$FadeWait.stop()

var count = 0
func _on_Fade_timeout():
	$CanvasLayer/LoadScreen.modulate.a -= 0.05
	count += 1
	if count > 20:
		call_deferred("free")
