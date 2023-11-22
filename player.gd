extends Area2D


@export var speed = 0
var acceleration = 1
var max_speed = 15
var rotation_speed = 1

var distance_initial = self.get_position()
var distance_traveled = null
var distance_to_spawn_line = 100

signal speed_counter(speed)
signal background_speed_increased(speed)
signal spawn_line()

var screen_size

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	
	var rotation_in_radians = deg_to_rad(rotation)
	
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_forward"):
		velocity.y -= 1
		if speed < max_speed:
			speed += acceleration * delta
		if distance_traveled == null:
			distance_traveled = 0
		distance_traveled += speed * delta
	else:		
		if speed > 0:
			speed -= acceleration * delta
			if distance_traveled != null:
				distance_traveled += position.y - distance_to_spawn_line
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
		
	
	if Input.is_action_pressed("turn_left"):
		velocity = Vector2(cos(rotation_in_radians), sin(rotation_in_radians)) * -1
		#rotate(rotation_speed * delta)
	if Input.is_action_pressed("turn_right"):
		velocity = Vector2(cos(rotation_in_radians), sin(rotation_in_radians))
		#rotate(-rotation_speed * delta)
			
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
		
	else:
		$AnimatedSprite2D.stop()
	
	velocity = velocity.normalized() * speed
	translate(velocity * delta)
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	print("distance_traveled: "+str(distance_traveled))
	print("distance_to_spawn_line: "+str(distance_to_spawn_line))
	print("position: "+str(position))
	
	if distance_traveled != null and distance_traveled >= distance_to_spawn_line:
		emit_signal("spawn_line")
		distance_traveled = 0
	
	emit_signal("speed_counter", speed)
	if position.y > 0:
		emit_signal("background_speed_increased", speed)
		

