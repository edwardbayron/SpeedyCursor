extends ParallaxBackground

var acceleration = 150
var max_speed = 1000
var distance_traveled
var parallax_background_size
var offset_test

signal distance_traveled_y(distance_traveled)
signal offset_test_signal(offset_test)

@export var camera_velocity: Vector2 = Vector2(0, 100)

func _ready():
	parallax_background_size = self.get_viewport().size.y
	print("parallax_background_size: "+str(parallax_background_size))
	
func _process(delta):
	_on_player_background_speed_increased(delta)
	distance_traveled = delta * get_scroll_offset()
	
	offset_test = get_scroll_offset() + camera_velocity * delta / acceleration
	var diff = offset_test.y - parallax_background_size

	
	emit_signal("distance_traveled_y", round(distance_traveled.y))
	emit_signal("offset_test_signal", parallax_background_size)
	print("distance_traveled: "+str(round(distance_traveled.y)))
	print("diff: "+str(diff))
	print("offset_test: "+str(offset_test))
	print("get_scroll_offset(): "+str(get_scroll_offset()))
	
		#SpawnCheckpointObject()
		
		#checkpoint_instance.queue_free()
		#checkpoint_instance = null
		#checkpoint_instance.global_position.y = get_scroll_offset().y + parallax_background_size / 2
		#checkpoint_instance.global_position.y = 100



func _on_player_background_speed_increased(speed):
	var new_offset: Vector2 = get_scroll_offset() + camera_velocity * speed / acceleration
	set_scroll_offset(new_offset)
