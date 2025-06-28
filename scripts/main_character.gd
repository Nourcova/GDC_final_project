extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -900.0
@onready var sprite_2d = $Sprite2D
@export var particle: PackedScene
var is_shrunk = false

var jump_count = 0

func jump():
	velocity.y = JUMP_VELOCITY
	spawn_particles()
	
func jump_side(x):
	velocity.y = JUMP_VELOCITY
	velocity.x = x
	
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
		
	# Add the gravity.
	if is_on_floor():
		jump_count = 0
		#Animations
		if abs(velocity.x) > 1:
			sprite_2d.animation = "running"
		else:
			sprite_2d.animation = "default"
	else:
		velocity += get_gravity() * delta
		if(jump_count == 2):
			sprite_2d.animation = "double_jumping"
		else:
			sprite_2d.animation = "jumping"
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and jump_count < 2:
		velocity.y = JUMP_VELOCITY
		jump_count += 1
		if jump_count == 2:
			spawn_particles()
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

func spawn_particles():
	var particle_node = particle.instantiate()
	particle_node.position = position
	get_parent().add_child(particle_node)
	await get_tree().create_timer(0.3).timeout
	particle_node.queue_free()
