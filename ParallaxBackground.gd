extends ParallaxBackground

var acceleration = 150
var max_speed = 1000

@export var camera_velocity: Vector2 = Vector2(0, 100)

func _ready():
	pass

func _process(delta):
	_on_player_background_speed_increased(delta)

func _on_player_background_speed_increased(speed):
	var new_offset: Vector2 = get_scroll_offset() + camera_velocity * speed / acceleration
	set_scroll_offset(new_offset)
	
