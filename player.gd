extends CharacterBody2D

@export var speed = 0
var acceleration = 10
var max_speed = 150
var distance_traveled = null
var player_movement_area
var screen_size
var new_position
var stopped_at_border
var top_y
var bottom_y

signal speed_counter(speed)
signal background_speed_increased(speed)
signal spawn_line
signal hit

signal player_picked_up_health
signal player_hit

func _ready():
	player_movement_area = $PlayerMovementArea/PlayerMovementCollision
	#top_y = position.y - player_movement_area.shape.extents.y
	#bottom_y = position.y + player_movement_area.shape.extents.y
	screen_size = get_viewport_rect().size


func _process(delta):
	var rotation_in_radians = deg_to_rad(rotation)
	var velocity = Vector2.ZERO
	new_position = position + velocity * delta
	
	
	if Input.is_action_pressed("move_forward"):
		velocity.y -= 0.5
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
		velocity.y += 10
	else:
		acceleration = 50
		if speed < 0:
			speed += acceleration * delta	
		velocity.y -= 1
	
	if Input.is_action_pressed("move_forward") && Input.is_action_pressed("turn_left"):
		velocity.y -= 100
		velocity.x -= 100
		
	if Input.is_action_pressed("move_forward") && Input.is_action_pressed("turn_right"):
		velocity.y -= 100
		velocity.x += 100
		
	if Input.is_action_pressed("move_reverse") && Input.is_action_pressed("turn_left"):
		velocity.y += 100
		velocity.x -= 100
		
	if Input.is_action_pressed("move_reverse") && Input.is_action_pressed("turn_right"):
		velocity.y += 100
		velocity.x += 100
	
	if Input.is_action_pressed("turn_left"):
		velocity.x -= 100
	if Input.is_action_pressed("turn_right"):
		velocity.x += 100
			
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
		
	else:
		$AnimatedSprite2D.stop()
	
	velocity = velocity.normalized() * speed
	#translate(velocity * delta)	
	
	var collision = move_and_collide(velocity * delta)
	
	collision_detect(collision)
	
	emit_signal("speed_counter", speed)
	if position.y > 0:
		emit_signal("background_speed_increased", speed)

func is_within_player_movement_area(position):
	return player_movement_area.global_position.distance_to(position) < player_movement_area.shape.extents.length()

func collision_detect(collision):
	if collision:
		print("I collided with ", collision.get_collider().name)
		emit_signal("player_hit")
	


func _on_health_pickup_body_entered(body):
	if body.name == "Player":
		print("ON HEALTH PICKED UP BY PLAYER")
		emit_signal("player_picked_up_health")


func _on_health_pickup_health_pickup_remove(node):
	remove_child(node)
	node.queue_free()
