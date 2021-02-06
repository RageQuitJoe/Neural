#/Game/Player/Lights
#Node of /Game/Player
extends Node2D
var switch = true

func _ready():
	timer()	

func timer():
	$Timer.set_wait_time(0.25)
	$Timer.start()

func _on_Timer_timeout():
	var battery_color = get_node("/root/Game/Player/Sprites").battery_color

	$Main.set_color(battery_color)
	if switch == true:
		switch = false
		$Main.set_energy(0.975)
		$Glow.set_energy(0.975)

	else:
		switch = true
		$Main.set_energy(1)
		$Glow.set_energy(1)
