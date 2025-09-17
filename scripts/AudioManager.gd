extends AudioStreamPlayer

# Simple Audio Manager for Amphorae
class_name AudioManager

static var instance: AudioManager

func _ready():
	instance = self
	# Set up audio bus
	bus = "Master"

static func play_sound(sound_name: String):
	"""Play a sound effect"""
	if instance:
		print("Playing sound: ", sound_name)
		# In a full implementation, this would load and play actual audio files
		# For now, we just print the sound name

static func play_music(music_name: String):
	"""Play background music"""
	if instance:
		print("Playing music: ", music_name)
		# In a full implementation, this would load and play music files