extends Control

# Main Menu for Amphorae: The Twelve Labours
class_name MainMenu

@onready var start_button = $VBoxContainer/StartButton
@onready var quit_button = $VBoxContainer/QuitButton
@onready var title_label = $VBoxContainer/TitleLabel

func _ready():
	start_button.pressed.connect(_on_start_pressed)
	quit_button.pressed.connect(_on_quit_pressed)

func _on_start_pressed():
	# Load the main game scene
	get_tree().change_scene_to_file("res://scenes/Main.tscn")

func _on_quit_pressed():
	# Quit the game
	get_tree().quit()