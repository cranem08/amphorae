extends Area2D

# Special cave entrance that makes the Nemean Lion vulnerable
class_name LionCave

@onready var nemean_lion: NemeanLion = null

func _ready():
	# Connect the body entered signal
	body_entered.connect(_on_body_entered)
	
	# Find the Nemean Lion in the scene
	nemean_lion = get_tree().get_first_node_in_group("nemean_lion")

func _on_body_entered(body):
	if body is Player:
		print("Heracles enters the lion's cave and discovers its weakness!")
		if nemean_lion:
			nemean_lion.make_vulnerable()
		# Remove the cave after use
		queue_free()