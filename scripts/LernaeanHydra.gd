extends CharacterBody2D

# Lernaean Hydra - Second Labour enemy
class_name LernaeanHydra

const SPEED = 50.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var heads = 3  # Number of heads remaining
var max_heads = 3
var player: Player = null
var regeneration_timer = 0.0
var regeneration_delay = 3.0

@onready var sprite = $Sprite
@onready var heads_container = $Sprite/HeadsContainer

func _ready():
	# Find the player and add to group
	player = get_tree().get_first_node_in_group("player")
	add_to_group("hydra")
	update_heads_display()

func _physics_process(delta):
	# Add gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Simple movement
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity.x = direction.x * SPEED
	
	move_and_slide()
	
	# Handle regeneration
	regeneration_timer += delta
	if regeneration_timer >= regeneration_delay and heads < max_heads:
		regenerate_head()

func take_damage(amount: int):
	"""Hydra loses a head but may regenerate"""
	heads -= amount
	print("Hydra loses a head! Heads remaining: ", heads)
	
	if heads <= 0:
		defeat()
	else:
		# Start regeneration timer
		regeneration_timer = 0.0
		update_heads_display()

func regenerate_head():
	"""Regenerate a head if not at maximum"""
	if heads < max_heads:
		heads += 1
		regeneration_timer = 0.0
		print("Hydra regenerates a head! Heads: ", heads)
		update_heads_display()

func update_heads_display():
	"""Update the visual representation of heads"""
	# Clear existing heads
	for child in heads_container.get_children():
		child.queue_free()
	
	# Add new heads
	for i in range(heads):
		var head = ColorRect.new()
		head.size = Vector2(16, 16)
		head.position = Vector2(i * 20 - 20, -20)
		head.color = Color(0.2, 0.6, 0.2, 1)
		heads_container.add_child(head)

func defeat():
	"""Called when all heads are cut and regeneration is prevented"""
	print("The Lernaean Hydra has been defeated!")
	if player:
		player.complete_task()
	queue_free()

func cauterize():
	"""Special method to prevent regeneration (puzzle solution)"""
	max_heads = heads  # Prevent further regeneration
	print("The Hydra's necks are cauterized - no more regeneration!")
	sprite.modulate = Color(1, 0.8, 0.8)