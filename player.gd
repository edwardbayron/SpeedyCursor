extends Area2D


@export var speed = 0
var acceleration = 10
var max_speed = 150
var rotation_speed = 1

var distance_initial = self.get_position()
var distance_traveled = null
var distance_to_spawn_line = 100
var player_movement_area
var screen_size
var new_position
var stopped_at_border
var top_y
var bottom_y

signal speed_counter(speed)
signal background_speed_increased(speed)
signal spawn_line


func _ready():
	player_movement_area = $PlayerMovementArea/PlayerMovementCollision
	top_y = position.y - player_movement_area.shape.extents.y
	bottom_y = position.y + player_movement_area.shape.extents.y
	screen_size = get_viewport_rect().size
	
	
	print("top_y: "+str(top_y))
	print("bottom_y: "+str(bottom_y))
	print("screen size: "+str(screen_size.y))

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
	
	print("self position y: "+str(self.position.y))
	print("player position in area: "+str(self.position.y - top_y))
	
	
	if is_within_player_movement_area(new_position):
		position = new_position
	else:
		if self.position.y <= top_y + 30:
			print("STOP TOP")
			position.y = player_movement_area.global_position.y - player_movement_area.shape.extents.y - 30
			
	
		elif self.position.y >= bottom_y - 30:
			print("STOP BOTTOM")
			position.y = player_movement_area.global_position.y + player_movement_area.shape.extents.y + 30
	
#	if distance_traveled != null and distance_traveled >= distance_to_spawn_line:
#		emit_signal("spawn_line")
#		distance_traveled = 0
	
	velocity = velocity.normalized() * speed
	translate(velocity * delta)	
	
	emit_signal("speed_counter", speed)
	if position.y > 0:
		emit_signal("background_speed_increased", speed)

func is_within_player_movement_area(position):
	return player_movement_area.global_position.distance_to(position) < player_movement_area.shape.extents.length()

func _on_player_movement_area_area_entered(area):
	print("entered")


func _on_player_movement_area_area_exited(area):
	print("exited")
