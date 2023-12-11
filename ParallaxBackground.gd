extends ParallaxBackground

var acceleration = 150
var max_speed = 1000
var distance_traveled
var parallax_background_size
var offset_test
var checkpoint_show = false

var checkpoint_area_scene
var checkpoint_area_instance

var checkpoint_starting_parallax_position = Vector2(277, 250)

@export var camera_velocity: Vector2 = Vector2(0, 100)

func _ready():
	parallax_background_size = self.get_viewport().size.y
	checkpoint_area_scene = load("res://checkpoint_area.tscn")
	checkpoint_area_instance = checkpoint_area_scene.instantiate()
	checkpoint_area_instance.position = checkpoint_starting_parallax_position
	checkpoint_area_instance.visible = false
	add_child(checkpoint_area_instance)
	
	
	print("parallax_background_size: "+str(parallax_background_size))

func _process(delta):
	_on_player_background_speed_increased(delta)
	distance_traveled = delta * get_scroll_offset()
	
	offset_test = get_scroll_offset() + camera_velocity * delta / acceleration
	var diff = offset_test.y - self.get_viewport().size.y
	checkpoint_starting_parallax_position = offset_test
	
	print("offset_test: "+str(offset_test))
	
	
	if distance_traveled.y >= 10:
		checkpoint_show = true
		checkpoint_area_instance.visible = true
		checkpoint_area_instance.position = offset_test - Vector2(offset_test.x, offset_test.y - diff)
		
	if offset_test.y >= 1900 && checkpoint_show == true:
		checkpoint_show = false
		print("HIDDEN")

func _on_player_background_speed_increased(speed):
	var new_offset: Vector2 = get_scroll_offset() + camera_velocity * speed / acceleration
	
	set_scroll_offset(new_offset)
	
