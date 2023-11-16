extends ParallaxBackground

@export var speed = 100.0

@export var direction = Vector2.DOWN

@export var camera_velocity: Vector2 = Vector2(0, 100)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#var new_offset: Vector2 = get_scroll_offset() + camera_velocity * delta
	#set_scroll_offset(new_offset)
	_on_player_background_speed_increased(delta)

func _on_player_background_speed_increased(speed):
	var new_offset: Vector2 = get_scroll_offset() + camera_velocity * speed
	set_scroll_offset(new_offset)
