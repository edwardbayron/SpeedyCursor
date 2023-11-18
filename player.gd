extends Area2D



@export var speed = 0
var acceleration = 150
var max_speed = 15
var rotation_speed = 1

signal speed_counter(speed)
signal background_speed_increased(speed)


var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var rotation_in_radians = deg_to_rad(rotation)
	
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_forward"):
		velocity.y -= 1
		if speed < max_speed:
			speed += acceleration * delta
	
	else:		
		if speed > 0:
			speed -= acceleration * delta
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
	
	
	emit_signal("speed_counter", speed)
	emit_signal("background_speed_increased", speed)

