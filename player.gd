extends Area2D



@export var speed = 200
var acceleration = 150
var max_speed = 1000
#test
#test test

signal speed_counter(speed)
signal background_speed_increased(speed)


var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_forward"):
		velocity.y -= 1
		if speed < max_speed:
			speed += acceleration * delta
	
	else:		
		if speed > 0:
			speed -= acceleration * delta
		velocity.y -= 1
		#velocity = velocity * speed
	
	if Input.is_action_pressed("move_reverse"):
		#velocity.y += 1
		#speed = 200
		#velocity.y -= 1
		velocity.y += -1
		if speed > -100:
			speed -= acceleration * delta
		elif speed < 0:
			speed += acceleration * delta
		velocity += Vector2(0, 1)
	else:
		acceleration = 50
		if speed < 0:
			speed += acceleration * delta	
		
	
	if Input.is_action_pressed("turn_left"):
		velocity.x += 1
	
			
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	
	emit_signal("speed_counter", speed)
	emit_signal("background_speed_increased", speed)

