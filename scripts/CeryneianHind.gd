extends CharacterBody2D

# Ceryneian Hind - Third Labour
class_name CeryneianHind

const SPEED = 300.0  # Very fast
const JUMP_VELOCITY = -300.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player: Player = null
var is_captured = false
var flee_timer = 0.0

@onready var sprite = $Sprite

func _ready():
	player = get_tree().get_first_node_in_group("player")
	add_to_group("hind")

func _physics_process(delta):
	if is_captured:
		return
		
	# Add gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Flee from player
	if player:
		var distance = global_position.distance_to(player.global_position)
		if distance < 200:  # Detection range
			var direction = (global_position - player.global_position).normalized()
			velocity.x = direction.x * SPEED
			
			# Jump if close to player
			if distance < 100 and is_on_floor():
				velocity.y = JUMP_VELOCITY
				
			# Face movement direction
			if direction.x > 0:
				sprite.scale.x = 1
			else:
				sprite.scale.x = -1
		else:
			# Slow down when not fleeing
			velocity.x = move_toward(velocity.x, 0, SPEED * 0.1)
	
	move_and_slide()

func capture():
	"""Capture the hind (requires special strategy)"""
	if not is_captured:
		is_captured = true
		velocity = Vector2.ZERO
		sprite.modulate = Color(1, 1, 0.5, 0.8)  # Golden tint
		print("The Ceryneian Hind has been captured!")
		if player:
			player.complete_task()

func try_capture():
	"""Attempt to capture - only works if player is very close and hind is tired"""
	var distance = global_position.distance_to(player.global_position) if player else 999
	if distance < 40:
		capture()