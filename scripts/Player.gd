extends CharacterBody2D

# Player controller for Heracles in Amphorae: The Twelve Labours
class_name Player

const SPEED = 200.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var is_facing_right = true

func _ready():
	# Add player to group for enemy detection
	add_to_group("player")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handle movement.
	var direction = Input.get_axis("move_left", "move_right")
	if direction != 0:
		velocity.x = direction * SPEED
		
		# Handle sprite flipping for direction
		if direction > 0 and not is_facing_right:
			flip_sprite()
		elif direction < 0 and is_facing_right:
			flip_sprite()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	# Handle interaction
	if Input.is_action_just_pressed("interact"):
		interact_with_environment()

func flip_sprite():
	"""Flip the player sprite to face the movement direction"""
	is_facing_right = !is_facing_right
	$Sprite.scale.x *= -1

func interact_with_environment():
	"""Handle interactions with the environment"""
	print("Heracles interacts with the environment")
	
	# Check for nearby enemies to attack
	var enemies = get_tree().get_nodes_in_group("nemean_lion")
	for enemy in enemies:
		if global_position.distance_to(enemy.global_position) < 50:
			enemy.take_damage(1)
			print("Heracles attacks the enemy!")

func take_damage(amount: int):
	"""Handle player taking damage"""
	print("Heracles takes ", amount, " damage!")
	# TODO: Implement health system

func complete_task():
	"""Called when the player completes a task in the current labour"""
	print("Task completed!")
	get_parent().complete_labour()