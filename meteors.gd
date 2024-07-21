extends RigidBody2D

func _ready():
	randomize()
	
	var meteor_types = $MeteorSprite.sprite_frames.get_animation_names()
	#$MeteorSprite.play(meteor_types[randi() % meteor_types.size()]) -- ANIMATION OF METEORS
	$MeteorSprite.rotation = randf_range(0, PI * 2)


func _process(delta):
	var rotation_amount = randf_range(0.01, 0.1)
	$MeteorSprite.rotation += rotation_amount
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_player_body_entered(body):
	print("ON BODY ENTERED")
	var meteor = get_node(".")
	meteor.rotation = PI * 2
	
