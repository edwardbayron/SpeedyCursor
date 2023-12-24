extends ParallaxBackground

var acceleration = 150
var max_speed = 1000
var distance_traveled
var parallax_background_size
var offset_test
var checkpoint_show = false

var checkpoint_area_scene
var checkpoint_area_instance
var checkpoint_created = false
var checkpoint_threshold = 10

#var checkpoint_starting_parallax_position = Vector2(277, 250)

@export var camera_velocity: Vector2 = Vector2(0, 100)

func _ready():
	parallax_background_size = self.get_viewport().size.y
	checkpoint_area_scene = load("res://checkpoint_area.tscn")
	
	#checkpoint_area_instance.position = checkpoint_starting_parallax_position
	
	print("parallax_background_size: "+str(parallax_background_size))

func _process(delta):
	_on_player_background_speed_increased(delta)
	distance_traveled = delta * get_scroll_offset()
	
	offset_test = get_scroll_offset() + camera_velocity * delta / acceleration
	var diff = offset_test.y - parallax_background_size
	#checkpoint_starting_parallax_position = offset_test
	
	
#	if distance_traveled.y >= 10:
#		checkpoint_area_instance = checkpoint_area_scene.instantiate()
#		checkpoint_show = true
#		add_child(checkpoint_area_instance)
#		checkpoint_area_instance.visible = true
#		checkpoint_area_instance.position = offset_test - Vector2(offset_test.x, offset_test.y - diff)
#		#checkpoint_area_instance.position = Vector2(0, 0)
#		print("SHOWNNNNN YOLO: "+str(distance_traveled))
#		print("checkpoint position: "+str(checkpoint_area_instance.position))
#		print("offset: "+str(offset_test))
#		if checkpoint_area_instance.position.y >= parallax_background_size:
#			
#			checkpoint_area_instance.free()
	
	if distance_traveled.y >= checkpoint_threshold && checkpoint_created == false:
		checkpoint_area_instance = checkpoint_area_scene.instantiate()
		#checkpoint_area_instance.position = offset_test

		add_child(checkpoint_area_instance)
		checkpoint_area_instance.visible = true
		checkpoint_created = true
		print("Checkpoint created at distance_traveled: " + str(distance_traveled))
		checkpoint_threshold += 10
		
	# checkpoint_area_instance && checkpoint_area_instance.is_queued_for_deletion() && 
	
	if checkpoint_created:
		checkpoint_area_instance.position = offset_test - Vector2(offset_test.x, offset_test.y - diff)
	
#	if checkpoint_area_instance.position.y >= parallax_background_size && checkpoint_created:
#		checkpoint_created = false
#		checkpoint_area_instance.queue_free()
#		print("Checkpoint removed at distance_traveled: " + str(distance_traveled))
			#remove_child(checkpoint_area_instance)
	
	
	
#	if checkpoint_area_instance.position.y >= parallax_background_size:
#		_remove_checkpoint()
#		checkpoint_area_instance.visible = false
	
		
		
#	print("offset_test: "+str(offset_test))
#	print("diff: "+str(diff))
#	print("checkpoint_area_instance.position: "+str(checkpoint_area_instance.position))
##	
#	if offset_test.y >= 1900 && checkpoint_show == true:
#		checkpoint_show = false
#		print("HIDDEN")
		

func _on_player_background_speed_increased(speed):
	var new_offset: Vector2 = get_scroll_offset() + camera_velocity * speed / acceleration
	set_scroll_offset(new_offset)
	
