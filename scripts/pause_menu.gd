extends CanvasLayer


func _ready():
	get_tree().paused = true

func _on_play_pressed():
	get_tree().paused = false
	queue_free()

func _on_quit_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/title_screen.tscn")
