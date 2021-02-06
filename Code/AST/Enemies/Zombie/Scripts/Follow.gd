extends Node2D

#### Follow Player #### 
# https://www.youtube.com/watch?v=UWlErVIJIw0&t=1337s
# https://www.youtube.com/watch?v=fnkgBaWKZNU
# https://www.youtube.com/watch?v=v4AfmliVhlM

onready var speed = get_node("/root/Game/Default").player_def_speed * 0.75
onready var player = get_node("/root/Game/Player")
onready var sprite = get_node("../Sprite") #sprite: Sprite = get_node("../Sprite")
onready var sightup = get_node("../Detect/Sight/UP")
onready var sightdw = get_node("../Detect/Sight/DW")
onready var sightlt = get_node("../Detect/Sight/LT")
onready var sightrt = get_node("../Detect/Sight/RT")
onready var anm = get_node("../Anm")

const DISTANCE_THRESHOLD: = 3.0 #Stop moving x number of pixels away from player.

var slow_radius: = 500 #Starts slowing down at x pixels from target.
var velocity: = Vector2.ZERO

func _physics_process(_delta: float) -> void:
	if get_parent().detect == true:
		var target_global_position: Vector2 = player.global_position
		
		if global_position.distance_to(target_global_position) < DISTANCE_THRESHOLD: return
		
		velocity = Steering.arrive_to(
			velocity,
			global_position,
			target_global_position,
			speed,
			slow_radius
		)
		velocity = get_parent().move_and_slide(velocity)
		var dir = int((get_angle_to(player.position)/3.14)*180)
		
		if dir > -135 and dir < -45:#UP
			sightup.disabled = false
			sightdw.disabled = true
			sightlt.disabled = true
			sightrt.disabled = true
			get_parent().anmstate = "up"
			anm.play("MV_UP");
		if dir > 45 and dir < 135:#DW
			sightup.disabled = true
			sightdw.disabled = false
			sightlt.disabled = true
			sightrt.disabled = true
			get_parent().anmstate = "dw"
			anm.play("MV_DW");
		if dir > -180 and dir < -135 or dir > 135 and dir < 180:#LT
			sightup.disabled = true
			sightdw.disabled = true
			sightlt.disabled = false
			sightrt.disabled = true
			get_parent().anmstate = "lt"
			anm.play("MV_LT");
		if dir > -45 and dir < 45:#RT
			sightup.disabled = true
			sightdw.disabled = true
			sightlt.disabled = true
			sightrt.disabled = false
			get_parent().anmstate = "rt"
			anm.play("MV_RT");
			
	if velocity == Vector2.ZERO:
		if get_parent().anmstate == "up":
			anm.play("ID_UP");
		if get_parent().anmstate == "dw":
			anm.play("ID_DW");
		if get_parent().anmstate == "lt":
			anm.play("ID_LT");
		if get_parent().anmstate == "rt":
			anm.play("ID_RT");
