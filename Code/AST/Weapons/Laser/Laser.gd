extends Node2D

#### Laser Beam ####
#https://www.youtube.com/watch?v=anJ2A2NmaVs
onready var playermov = get_node("/root/Game/Player/Movement")

onready var beam = $Beam
onready var orb =$Orb
onready var endorb = $EndOrb
onready var endpoint = $EndPoint
onready var orbcol = $Orb/OrbArea/OrbCol
onready var endorbcol = $EndOrb/EndOrbArea/EndOrbCol
onready var rayCast2D = $RayCast2D

const MAX_LENGTH = 1000

var laser_on = false
var laser_rot = false
var direction = Vector2(0,1)

func _ready():
	$RayCast2D.add_exception(get_node("/root/Game/Player")) #Prevent raycast from colliding with player.

var orb_powerup = false

var orbpd = 0.05 # % of battery capcity orb damage/drian
var laserpd = 0.25 # % of battery capcity laser damage/drian

func _physics_process(_delta):
#### Turn on Orb ####
	if Input.is_action_just_pressed("Orb"):
		if laser_on == false and orb_powerup == false:
			orb_powerup = true
			#Modulate Color
			var battery_color = get_node("/root/Game/Player/Sprites").battery_color
			modulate = battery_color
			modulate.a = 0
			$Color.timer()
			#Set direction of Orb in direction of player animation state 
			var player_anmstate = get_node("/root/Game/Player/Movement").anmstat
			if player_anmstate == "up": #UP
				direction = Vector2.UP
			if player_anmstate == "dw": #DW
				direction = Vector2.DOWN
			if player_anmstate == "lt":#LT
				direction = Vector2.LEFT
			if player_anmstate == "rt":#RT
				direction = Vector2.RIGHT
			
			#$Audio/Orb.play()
			laser_rot = true
			orbcol.disabled = false
			orb.visible = true
			
			get_node("/root/Game/Default").damage += get_node("/root/Game/Player/Battery").battery_capacity * orbpd
			get_node("/root/Game/Player/Battery").battery_drain += (get_node("/root/Game/Player/Battery").battery_capacity * orbpd) * 2

		else:
			orb_powerup = false
			$Color.stop()
			get_node("/root/Game/Player/Battery").battery_drain -= (get_node("/root/Game/Player/Battery").battery_capacity * orbpd) * 2
			get_node("/root/Game/Default").damage -= get_node("/root/Game/Player/Battery").battery_capacity * orbpd
			
			#$Audio/Orb.stop()
			laser_rot = false
			laser_on = false
			orbcol.disabled = true
			orb.visible = false

#### Fire Laser ####
	if laser_on == true:
		if Input.is_action_pressed("Fire"):
			get_node("/root/Game/Default").damage += get_node("/root/Game/Player/Battery").battery_capacity * laserpd
			get_node("/root/Game/Player/Battery").battery_drain += get_node("/root/Game/Player/Battery").battery_capacity * laserpd
			
			get_node("/root/Game/Player/Camera").add_trauma(0.05)

			get_node("/root/Game/Default").kickback = 1.5
			playermov.fire = true
			endorbcol.disabled = false
			#$Audio/Laser.play()
			rayCast2D.enabled = true
			beam.visible = true
			endorb.visible = true
		if Input.is_action_just_released("Fire"):
			if playermov.fire == true:
				get_node("/root/Game/Default").damage -= get_node("/root/Game/Player/Battery").battery_capacity * laserpd
				get_node("/root/Game/Player/Battery").battery_drain -= get_node("/root/Game/Player/Battery").battery_capacity * laserpd
				
				get_node("/root/Game/Default").kickback = 1
				playermov.fire = false
				endorbcol.disabled = true
				#$Audio/Laser.stop()
				rayCast2D.enabled = false
				beam.visible = false
				endorb.visible = false

	## Length of Raycast2D and Beam ##
	rayCast2D.cast_to = direction.normalized() * MAX_LENGTH 
	beam.region_rect.end.x = endpoint.position.length()-48
	## Stop laser beam when it colldies with anything on col mask 1 ##
	if rayCast2D.is_colliding():
		endpoint.global_position = rayCast2D.get_collision_point()
		endorbcol.global_position = rayCast2D.get_collision_point()
		endorb.global_position = rayCast2D.get_collision_point()
	else:
		endpoint.position = rayCast2D.cast_to
		endorbcol.position = rayCast2D.cast_to
		endorb.position = rayCast2D.cast_to

#### Rotate Laser ####
	if laser_rot == true:
		## Right joystick's curent x/y axis ##
		var joy_axis = Vector2(
			Input.get_joy_axis(0, JOY_AXIS_2),
			Input.get_joy_axis(0, JOY_AXIS_3)
			)
		## Roate if right joystick moved ##
		if joy_axis.x > 0.1 or joy_axis.y < -0.1 or joy_axis.x < -0.1 or joy_axis.y > 0.1:
			direction = Vector2(
			Input.get_joy_axis(0, JOY_AXIS_2),
			Input.get_joy_axis(0, JOY_AXIS_3)
			)
	beam.rotation = rayCast2D.cast_to.angle()
	orb.rotation = rayCast2D.cast_to.angle()
	endorb.rotation = rayCast2D.cast_to.angle()
