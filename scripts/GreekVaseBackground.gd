extends ColorRect

# Greek Vase Background - Creates the terracotta background with black-figure aesthetic
class_name GreekVaseBackground

func _ready():
	# Set the terracotta/orange background color typical of Greek pottery
	color = Color(0.8, 0.5, 0.3, 1)
	
	# Add decorative border patterns
	add_decorative_border()

func add_decorative_border():
	"""Add Greek-style decorative borders"""
	# Top border
	var top_border = ColorRect.new()
	top_border.size = Vector2(1280, 40)
	top_border.position = Vector2(0, 0)
	top_border.color = Color(0.1, 0.1, 0.1, 1)  # Black
	add_child(top_border)
	
	# Add Greek key pattern elements
	for i in range(8):
		var key_element = ColorRect.new()
		key_element.size = Vector2(20, 20)
		key_element.position = Vector2(i * 160 + 80, 10)
		key_element.color = Color(0.8, 0.5, 0.3, 1)  # Terracotta cutout
		top_border.add_child(key_element)
	
	# Bottom border
	var bottom_border = ColorRect.new()
	bottom_border.size = Vector2(1280, 40)
	bottom_border.position = Vector2(0, 680)
	bottom_border.color = Color(0.1, 0.1, 0.1, 1)  # Black
	add_child(bottom_border)
	
	# Add wave pattern to bottom
	for i in range(16):
		var wave_element = ColorRect.new()
		wave_element.size = Vector2(10, 10)
		wave_element.position = Vector2(i * 80 + 40, 695)
		wave_element.color = Color(0.8, 0.5, 0.3, 1)  # Terracotta cutout
		bottom_border.add_child(wave_element)