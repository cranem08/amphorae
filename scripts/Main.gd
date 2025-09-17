extends Node2D

# Main game controller for Amphorae: The Twelve Labours
class_name Main

@onready var player = $Player
@onready var camera = $Camera2D
@onready var ui_title = $UI/GameTitle
@onready var ui_labour_info = $UI/LabourInfo

var current_labour = 1
var total_labours = 12

# Preload scenes for different labours
var nemean_lion_scene = preload("res://scenes/NemeanLion.tscn")
var lion_cave_scene = preload("res://scenes/LionCave.tscn")
var hydra_scene = preload("res://scenes/LernaeanHydra.tscn")
var torch_scene = preload("res://scenes/FireTorch.tscn")

var current_level_nodes = []

func _ready():
	# Initialize the first labour
	setup_labour(current_labour)
	update_ui()
	
	# Set camera to follow player
	if player:
		camera.position = player.position

func _process(_delta):
	# Update camera to follow player
	if player:
		camera.position = camera.position.lerp(player.position, 0.1)

func update_ui():
	"""Update the UI with current labour information"""
	ui_title.text = "Amphorae: The Twelve Labours"
	ui_labour_info.text = get_labour_name(current_labour) + " (" + str(current_labour) + "/" + str(total_labours) + ")"

func get_labour_name(labour_number: int) -> String:
	"""Get the name of the specified labour"""
	var labour_names = [
		"The Nemean Lion",
		"The Lernaean Hydra", 
		"The Ceryneian Hind",
		"The Erymanthian Boar",
		"The Augean Stables",
		"The Stymphalian Birds",
		"The Cretan Bull",
		"The Mares of Diomedes",
		"The Belt of Hippolyta",
		"The Cattle of Geryon",
		"The Apples of Hesperides",
		"Cerberus"
	]
	
	if labour_number > 0 and labour_number <= labour_names.size():
		return labour_names[labour_number - 1]
	else:
		return "Unknown Labour"

func clear_current_level():
	"""Remove all current level elements"""
	for node in current_level_nodes:
		if is_instance_valid(node):
			node.queue_free()
	current_level_nodes.clear()

func setup_labour(labour_number: int):
	"""Setup the current labour/level"""
	clear_current_level()
	print("Setting up Labour ", labour_number, ": ", get_labour_name(labour_number))
	
	match labour_number:
		1:
			setup_nemean_lion()
		2:
			setup_lernaean_hydra()
		_:
			print("Labour ", labour_number, " not implemented yet")
			if labour_number <= total_labours:
				# Show placeholder for unimplemented labours
				show_labour_placeholder(labour_number)

func setup_nemean_lion():
	"""Setup the first labour: Slay the Nemean Lion"""
	print("The Nemean Lion - A lion with impenetrable hide")
	
	# Add the lion
	var lion = nemean_lion_scene.instantiate()
	lion.position = Vector2(500, 500)
	add_child(lion)
	current_level_nodes.append(lion)
	
	# Add the cave
	var cave = lion_cave_scene.instantiate()
	cave.position = Vector2(800, 576)
	add_child(cave)
	current_level_nodes.append(cave)

func setup_lernaean_hydra():
	"""Setup the second labour: Kill the Lernaean Hydra"""
	print("The Lernaean Hydra - A serpent that regrows its heads")
	
	# Add the hydra
	var hydra = hydra_scene.instantiate()
	hydra.position = Vector2(600, 500)
	add_child(hydra)
	current_level_nodes.append(hydra)
	
	# Add a torch for cauterization
	var torch = torch_scene.instantiate()
	torch.position = Vector2(300, 576)
	add_child(torch)
	current_level_nodes.append(torch)

func show_labour_placeholder(labour_number: int):
	"""Show a placeholder for unimplemented labours"""
	print("Labour ", labour_number, " (", get_labour_name(labour_number), ") - Coming Soon!")
	# For now, just allow progression
	await get_tree().create_timer(2.0).timeout
	complete_labour()

func complete_labour():
	"""Called when the current labour is completed"""
	current_labour += 1
	if current_labour <= total_labours:
		print("Labour completed! Moving to next labour...")
		await get_tree().create_timer(1.0).timeout
		setup_labour(current_labour)
		update_ui()
	else:
		game_completed()

func game_completed():
	"""Called when all twelve labours are completed"""
	print("All Twelve Labours completed! Heracles has achieved immortality!")
	ui_labour_info.text = "ALL LABOURS COMPLETE!"
	# TODO: Add ending sequence