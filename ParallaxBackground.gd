extends ParallaxBackground

var acceleration = 150
var max_speed = 1000
var distance_traveled = Vector2(0, 0)
var parallax_background_size = 1024
var offset_test
var copy_distance_traveled = Vector2(0, 0)
var checkpoint_show_on_parallax = 0

signal distance_traveled_y(distance_traveled)
signal background_size(parallax_background_size)
signal background_offset_changing(offset, get_scroll_offset, acceleration, delta)

@export var camera_velocity: Vector2 = Vector2(0, 100)

func _ready():
	parallax_background_size = self.get_viewport().size.y
	print("parallax_background_size: "+str(parallax_background_size))
	
func _process(delta):
	_on_player_background_speed_increased(delta)
	
	distance_traveled = delta * get_scroll_offset()
	offset_test = get_scroll_offset() + camera_velocity * delta / acceleration
	
	#copy_distance_traveled = distance_traveled.y
	copy_distance_traveled = distance_traveled
	if copy_distance_traveled.y >= 100 && copy_distance_traveled.y <= 110:
		#distance_traveled = Vector2(0, 0)
		copy_distance_traveled = Vector2(0, 0)
		copy_distance_traveled.y = distance_traveled.y - 100
	
	checkpoint_show_on_parallax = offset_test.y
	if checkpoint_show_on_parallax >= parallax_background_size:
		checkpoint_show_on_parallax = 0
		#offset_test = 0
	
	emit_signal("distance_traveled_y", round(distance_traveled.y))
	emit_signal("offset_test_signal", parallax_background_size)
	emit_signal("background_offset_changing", offset_test, get_scroll_offset(), acceleration, delta)
	
#	print("delta: "+str(delta))
	#print("copy_distance_traveled: "+str(round(copy_distance_traveled.y)))
	#print("distance_traveled: "+str(round(distance_traveled.y)))
	#print("checkpoint_show_on_parallax: "+str(round(checkpoint_show_on_parallax)))
#	print("offset_test: "+str(offset_test))
#	print("get_scroll_offset(): "+str(get_scroll_offset()))


func _on_player_background_speed_increased(speed):
	var new_offset: Vector2 = get_scroll_offset() + camera_velocity * speed / acceleration
	set_scroll_offset(new_offset)
