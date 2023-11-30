extends Area2D


@export var speed = 0
var acceleration = 1
var max_speed = 15
var rotation_speed = 1

var distance_initial = self.get_position()
var distance_traveled = null
var distance_to_spawn_line = 100
var player_movement_area
var screen_size
var new_position

signal speed_counter(speed)
signal background_speed_increased(speed)
signal spawn_line


func _ready():
	player_movement_area = $PlayerMovementArea/PlayerMovementCollision
	#player_movement_area_size = $PlayerMovementArea/PlayerMovementCollision.shape.extents
	screen_size = get_viewport_rect().size

func _process(delta):
	var rotation_in_radians = deg_to_rad(rotation)
	var velocity = Vector2.ZERO
	new_position = position + velocity * delta
	
	
	
	if Input.is_action_pressed("move_forward"):
		velocity.y -= 1
		if speed < max_speed:
			speed += acceleration * delta
#		if distance_traveled == null:
#			distance_traveled = 0
#		distance_traveled += speed * delta
	else:		
		if speed > 0:
			speed -= acceleration * delta
#			if distance_traveled != null:
#				distance_traveled += position.y - distance_to_spawn_line
		velocity.y += 1

	if Input.is_action_pressed("move_reverse"):
		if speed > -15:
			speed -= acceleration * delta
		elif speed < 0:
			speed += acceleration * delta
		velocity.y += 1
	else:
		acceleration = 10
		if speed < 0:
			speed += acceleration * delta	
		velocity.y -= 1
	
#	if Input.is_action_pressed("turn_left"):
#		velocity = Vector2(cos(rotation_in_radians), sin(rotation_in_radians)) * -1
#		#rotate(rotation_speed * delta)
#	if Input.is_action_pressed("turn_right"):
#		velocity = Vector2(cos(rotation_in_radians), sin(rotation_in_radians))
#		#rotate(-rotation_speed * delta)
			
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
		
	else:
		$AnimatedSprite2D.stop()
	
	if is_within_player_movement_area(new_position):
		position = new_position
		if speed < 0:
			velocity.y -= 1
		velocity = velocity.normalized() * speed
		translate(velocity * delta)
	else:
		position = player_movement_area.global_position - new_position - delta * velocity
	
#	if distance_traveled != null and distance_traveled >= distance_to_spawn_line:
#		emit_signal("spawn_line")
#		distance_traveled = 0
	
	emit_signal("speed_counter", speed)
	if position.y > 0:
		emit_signal("background_speed_increased", speed)

func is_within_player_movement_area(position):
	return player_movement_area.global_position.distance_to(position) <= player_movement_area.shape.extents.length()

func _on_player_movement_area_area_entered(area):
	print("entered")


func _on_player_movement_area_area_exited(area):
	print("exited")
