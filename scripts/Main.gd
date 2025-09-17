extends Node2D

# Main game controller for Amphorae: The Twelve Labours
class_name Main

@onready var player = $Player
@onready var camera = $Camera2D

var current_labour = 1
var total_labours = 12

func _ready():
	# Initialize the first labour
	setup_labour(current_labour)
	
	# Set camera to follow player
	if player:
		camera.position = player.position

func _process(_delta):
	# Update camera to follow player
	if player:
		camera.position = camera.position.lerp(player.position, 0.1)

func setup_labour(labour_number: int):
	"""Setup the current labour/level"""
	print("Setting up Labour ", labour_number, " of ", total_labours)
	
	match labour_number:
		1:
			setup_nemean_lion()
		2:
			setup_lernaean_hydra()
		_:
			print("Labour ", labour_number, " not implemented yet")

func setup_nemean_lion():
	"""Setup the first labour: Slay the Nemean Lion"""
	print("The Nemean Lion - Labour 1")
	# TODO: Add specific level design for this labour

func setup_lernaean_hydra():
	"""Setup the second labour: Kill the Lernaean Hydra"""
	print("The Lernaean Hydra - Labour 2")
	# TODO: Add specific level design for this labour

func complete_labour():
	"""Called when the current labour is completed"""
	current_labour += 1
	if current_labour <= total_labours:
		setup_labour(current_labour)
	else:
		game_completed()

func game_completed():
	"""Called when all twelve labours are completed"""
	print("All Twelve Labours completed! Heracles has achieved immortality!")
	# TODO: Add ending sequence