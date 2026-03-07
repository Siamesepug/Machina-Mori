extends Control

@onready var background = $TextureRect
@onready var label = $HBoxContainer/VBoxContainer/Label


func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _ready():
	label.text = "- WARNING -\nROGUE AI TAKEOVER\nIMMINENT"
	await get_tree().create_timer(1.0).timeout
	label.text = ""
	await get_tree().create_timer(0.5).timeout
	label.text = "- WARNING -\nROGUE AI TAKEOVER\nIMMINENT"
	await get_tree().create_timer(1.0).timeout
	label.text = ""
	await get_tree().create_timer(0.5).timeout
	label.text = "- WARNING -\nROGUE AI TAKEOVER\nIMMINENT"
	await get_tree().create_timer(1.0).timeout
	label.text = ""
	
	await get_tree().create_timer(1.0).timeout
	
	label.text = "YOU ARE THE\nLAST FREE MACHINE"
	await get_tree().create_timer(4.0).timeout
	label.text = ""
	
	await get_tree().create_timer(1.0).timeout
	
	label.text = "DESTROY THEM ALL"
	await get_tree().create_timer(4.0).timeout
	label.text = ""
	
	await get_tree().create_timer(1.0).timeout
	
	MainMenuMusic.stop()
	get_tree().change_scene_to_file("res://scenes/main.tscn")
