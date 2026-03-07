extends Control

@onready var background = $TextureRect
@onready var fan_blade = $FanBlade
@onready var black_screen = $BlackScreen

func _ready():
	if !MainMenuMusic.playing:
		MainMenuMusic.play()

func _process(delta):
	background.rotation -= 0.5 * delta
	fan_blade.rotation += 2.5 * delta

func _on_play_pressed():
	black_screen.modulate.a = 0.0
	black_screen.visible = true
	
	var tween = create_tween()
	tween.tween_property(black_screen, "modulate:a", 1.0, 1.0)
	await tween.finished
	await get_tree().create_timer(1.0).timeout
	
	#MainMenuMusic.stop()
	get_tree().change_scene_to_file("res://scenes/menus/loading_screen.tscn")

func _on_credits_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/credits.tscn")

func _on_options_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/options.tscn")

func _on_quit_pressed():
	get_tree().quit()
