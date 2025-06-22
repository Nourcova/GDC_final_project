extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -900.0
@onready var sprite_2d = $Sprite2D
var is_shrunk = false

func _physics_process(delta):
	if Input.is_key_pressed(KEY_CTRL):
		if not is_shrunk:
			scale = Vector2(0.5, 0.5)
			is_shrunk = true
	else:
		if is_shrunk:
			# Move the character up *before* scaling up
			global_position.y -= 16  # adjust this value to match your character's height difference
			scale = Vector2(1, 1)
			is_shrunk = false
	#Animations
	if abs(velocity.x) > 1:
		sprite_2d.animation = "running"
	else:
		sprite_2d.animation = "default"
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		sprite_2d.animation = "jumping"

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 30)

	move_and_slide()
	
	var isLeft = velocity.x < 0
	if velocity.x != 0:
		sprite_2d.flip_h = velocity.x < 0
		
