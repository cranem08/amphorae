extends CharacterBody2D

# Nemean Lion - First Labour enemy
class_name NemeanLion

const SPEED = 100.0
const JUMP_VELOCITY = -200.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player: Player = null
var health = 3
var is_invulnerable = true  # The Nemean Lion is invulnerable to normal attacks

@onready var sprite = $Sprite
@onready var detection_area = $DetectionArea

func _ready():
	# Find the player
	player = get_tree().get_first_node_in_group("player")
	# Add to nemean_lion group
	add_to_group("nemean_lion")

func _physics_process(delta):
	# Add gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Simple AI: move towards player if detected
	if player and detection_area.has_overlapping_bodies():
		var direction = (player.global_position - global_position).normalized()
		velocity.x = direction.x * SPEED
		
		# Face the player
		if direction.x > 0:
			sprite.scale.x = 1
		else:
			sprite.scale.x = -1
	else:
		# Patrol behavior when player not detected
		velocity.x = move_toward(velocity.x, 0, SPEED * 0.5)
	
	move_and_slide()

func take_damage(amount: int):
	"""The Nemean Lion is invulnerable to normal attacks"""
	if is_invulnerable:
		print("The Nemean Lion's hide is too tough!")
		return
	
	health -= amount
	if health <= 0:
		defeat()

func defeat():
	"""Called when the Nemean Lion is defeated"""
	print("The Nemean Lion has been defeated!")
	# TODO: Add death animation and reward
	if player:
		player.complete_task()
	queue_free()

func make_vulnerable():
	"""Special method to make the lion vulnerable (puzzle solution)"""
	is_invulnerable = false
	print("The Nemean Lion becomes vulnerable!")
	# Change color to indicate vulnerability
	sprite.modulate = Color(1, 0.8, 0.8)