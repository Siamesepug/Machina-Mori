extends Control

@onready var background = $TextureRect


func _process(delta):
	background.rotation -= 0.5 * delta

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/title_screen.tscn")
