extends Control

@onready var background = $TextureRect
@onready var volume_slider = $HBoxContainer/VBoxContainer/VBoxContainer/VolumeSlider

var bus_index : int

func _ready():
	bus_index = AudioServer.get_bus_index("Master")
	var current_db = AudioServer.get_bus_volume_db(bus_index)
	volume_slider.value = db_to_linear(current_db)

func _process(delta):
	background.rotation -= 0.5 * delta

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/title_screen.tscn")

func _on_fullscreen_pressed():
	print("SETTING FULLSCREEN")
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)


func _on_h_slider_value_changed(value):
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	
