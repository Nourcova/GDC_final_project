extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.name == "CharacterBody2D":
		var y_delta = position.y - body.position.y
		print(y_delta)
		if y_delta >80:
			print("Destroy enemy")
			queue_free()
			body.jump()
		else:
			print("Decrease player health")
			body.queue_free()
