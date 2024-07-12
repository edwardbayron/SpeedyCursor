extends Area2D

var health_pickup_node
var health_pickups = []
const SCROLL_SPEED_FACTOR = 10 # 10 is because less will be weird, right now its okay

signal health_pickup_remove(node)

func _ready():
	spawn_health_pickup()
	
func _process(delta):
	var scroll_offset = GameState.get_scroll_offset_main.y * delta
	update_health_pickups(scroll_offset)
	#emit_signal("health_pickup_remove", health_pickup_node)

func spawn_health_pickup():
	health_pickup_node = get_node(".")
	var main_node_size = get_parent().get_viewport().size
	var health_spawn_range_x = randf_range(0, main_node_size.x)
	var health_spawn_range_y = randf_range(0, main_node_size.y)
	print("health_spawn_range_x: "+str(health_spawn_range_x))
	print("health_spawn_range_y: "+str(health_spawn_range_y))
	health_pickup_node.position = Vector2(50, 10)
	add_child(health_pickup_node)
	health_pickups.append(health_pickup_node)

func remove_health_pickup():
	remove_child(health_pickup_node)
	health_pickup_node.queue_free()
	
func update_health_pickups(scroll_offset):
	for health_pickup in health_pickups:
		health_pickup.position.y = scroll_offset * SCROLL_SPEED_FACTOR
		#print("After update:", health_pickup.position.y)
		if health_pickup.position.y > 1024:
			health_pickups.erase(health_pickup)
			health_pickup.queue_free()


func _on_player_player_picked_up_health():
	emit_signal("health_pickup_remove", health_pickup_node)
