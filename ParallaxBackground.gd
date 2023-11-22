extends ParallaxBackground

var acceleration = 150
var max_speed = 1000

#var distance_initial
#var distance_traveled = 0
#var distance_to_spawn_line = 100

@export var direction = Vector2.DOWN

@export var camera_velocity: Vector2 = Vector2(0, 100)

func _ready():
	pass

func _process(delta):
	_on_player_background_speed_increased(delta)

func _on_player_background_speed_increased(speed):
	#distance_initial = position
	var new_offset: Vector2 = get_scroll_offset() + camera_velocity * speed / acceleration
	set_scroll_offset(new_offset)
	
	#distance_traveled += -position
	
	#print("distance_initial: "+str(distance_initial))
	#print("distance_traveled: "+str(distance_traveled))
	#print("distance_to_spawn_line: "+str(distance_to_spawn_line))
	#print("position: "+str(position))
	#print("position - distance_to_spawn_line: "+str(position - distance_to_spawn_line))
	
	#if distance_traveled >= distance_to_spawn_line:
	#	distance_traveled = 0
	#	emit_signal("spawn_line", distance_traveled)
