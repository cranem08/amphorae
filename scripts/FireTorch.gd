extends Area2D

# Fire Torch - Used to cauterize the Hydra's necks
class_name FireTorch

var is_lit = false
@onready var flame = $Sprite/Flame

func _ready():
	body_entered.connect(_on_body_entered)
	add_to_group("torch")

func _on_body_entered(body):
	if body is Player and Input.is_action_pressed("interact"):
		if not is_lit:
			light_torch()
		else:
			# Try to cauterize hydra
			var hydras = get_tree().get_nodes_in_group("hydra")
			for hydra in hydras:
				if global_position.distance_to(hydra.global_position) < 100:
					hydra.cauterize()
					print("Heracles uses the torch to cauterize the Hydra!")

func light_torch():
	"""Light the torch"""
	if not is_lit:
		is_lit = true
		flame.visible = true
		flame.color = Color(1, 0.5, 0, 1)
		print("The torch is now lit!")