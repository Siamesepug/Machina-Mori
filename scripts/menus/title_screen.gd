extends Control

@onready var background = $TextureRect
@onready var fan_blade = $FanBlade
@onready var black_screen = $BlackScreen

func _ready():
	if !MainMenuMusic.playing:
		MainMenuMusic.play()

func _process(delta):
	background.rotation += 0.5 * delta
	fan_blade.rotation += 2.5 * delta

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/choose_mode.tscn")
	

func _on_credits_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/credits.tscn")

func _on_options_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/options.tscn")

func _on_quit_pressed():
	get_tree().quit()
