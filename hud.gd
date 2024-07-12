extends Control

var health_box_elements

# Called when the node enters the scene tree for the first time.
func _ready():
	health_box_elements = $HealthBoxContainer.get_children()
	update_decrease_health()
	
func update_speed(speed):
	$Speed.text = str(speed)

func update_increase_health():
	if health_box_elements.size() < 5:
		var new_health_rect = ColorRect.new()
		new_health_rect.color = Color(133, 255, 0, 255)
		new_health_rect.set_custom_minimum_size(Vector2(5, 0))
		$HealthBoxContainer.add_child(new_health_rect)
		health_box_elements.append(new_health_rect)

func update_decrease_health():
	if health_box_elements.size() > 0:
		var health_rect = health_box_elements.pop_front()
		$HealthBoxContainer.remove_child(health_rect)
		health_rect.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_speed_counter(speed):
	$Speed.text = str(speed)


func _on_player_player_picked_up_health():
	update_increase_health()


func _on_player_player_hit():
	update_decrease_health()
