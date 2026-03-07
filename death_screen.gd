extends CanvasLayer

@onready var background = $TextureRect
@onready var death_screen_menu = $HBoxContainer


func _ready():
	background.modulate.a = 0.0
	death_screen_menu.visible = false
	
	var tween = create_tween()
	
	tween.tween_property(background, "modulate:a", 1.0, 1.0)
	await tween.finished
	await get_tree().create_timer(1.0).timeout
	
	_display_death_menu()

func _display_death_menu():
	get_tree().paused = true
	death_screen_menu.visible = true


func _on_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menus/title_screen.tscn")
	MainMenuMusic.play()


func _on_quit_pressed():
	get_tree().quit()
