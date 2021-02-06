extends Node2D


const ZOMBIES = 10
var	remzom = ZOMBIES
var time = 10



func _ready():
	for z in range(ZOMBIES):
		zombiegen()

func _process(delta):
	if remzom <= 0:
		timer()
		remzom = ZOMBIES
	if get_node("/root/Debug").debug == true:
		$Debug.visible = true
		$Pad.visible = true
		$Debug/Zombies.set_text(str(remzom)+"/"+str(ZOMBIES))
		$Debug/Time.set_text(str(time))
	if get_node("/root/Debug").debug == false:
		$Debug.visible = false
		$Pad.visible = false

func zombiegen():
	var inst_zombie = load("res://AST/Enemies/Zombie/Zombie.tscn").instance()
	inst_zombie.position =  position + Vector2(rngx(),rngy()) #Position instanced chunk.
	add_child(inst_zombie)

func rngx():
	var rngx = RandomNumberGenerator.new()
	rngx.randomize()
	rngx = rngx.randi_range(-1500,1500)
	return rngx

func rngy():
	var rngy = RandomNumberGenerator.new()
	rngy.randomize()
	rngy = rngy.randi_range(-736,736) 
	return rngy

func timer():
	$Timer.set_wait_time(1)
	$Timer.start()

func _on_Timer_timeout():
	time -= 1
	if time <= 0:
		$Timer.stop()
		time = 10
		for z in range(ZOMBIES):
			zombiegen()
