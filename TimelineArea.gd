extends Area2D

signal checkpoint_passed

# Called when the node enters the scene tree for the first time.
func _ready():
	$TimelineAreaSprite.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_player_spawn_line():
	#print("SPAWN LINE")
	$TimelineAreaSprite.show()

func _on_body_entered(body):
	print("ON BODY ENTERED")
	monitoring = true
	checkpoint_passed.emit()
	$CollisionShape2D.set_deferred("disabled", true)


func _on_area_entered(area):
	print("ON AREA ENTERED")
	monitoring = true
	checkpoint_passed.emit()
	$CollisionShape2D.set_deferred("disabled", true)


func _on_player_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	print("ON AREA ENTERED")
	monitoring = true
	checkpoint_passed.emit()
	$CollisionShape2D.set_deferred("disabled", true)
