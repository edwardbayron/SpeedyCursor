extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func update_speed(speed):
	$Speed.text = str(speed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_speed_counter(speed):
	$Speed.text = str(speed)
