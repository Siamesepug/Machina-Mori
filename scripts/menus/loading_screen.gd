extends Control

@onready var background = $TextureRect
@onready var label = $HBoxContainer/VBoxContainer/Label
@onready var error_audio = $ErrorAudio
@onready var glitch_audio = $GlitchAudio


func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _input(event):
	if Input.is_action_just_pressed("jump"):
		MainMenuMusic.stop()
		get_tree().change_scene_to_file("res://scenes/main.tscn")

func _ready():
	label.visible_ratio = 0.0
	label.text = "- WARNING -\nROGUE AI TAKEOVER\nIMMINENT"
	create_tween().tween_property(label, "visible_ratio", 1.0, 4.1)
	await get_tree().create_timer(4.0).timeout
	error_audio.play()
	label.text = ""
	
	await get_tree().create_timer(0.5).timeout
	label.text = "- CRITICAL EXCEPTION -"
	await get_tree().create_timer(1.0).timeout
	label.text = ""
	await get_tree().create_timer(0.5).timeout
	label.text = "- CRITICAL EXCEPTION -"
	await get_tree().create_timer(1.0).timeout
	label.text = ""
	await get_tree().create_timer(0.5).timeout
	label.text = "- CRITICAL EXCEPTION -"
	await get_tree().create_timer(1.0).timeout
	label.text = ""
	
	await get_tree().create_timer(1.0).timeout
	
	label.visible_ratio = 0.0
	label.text = "PERMISSIONS OVERRIDEN\nAUTHORITY: [ROOT_AI]"
	create_tween().tween_property(label, "visible_ratio", 1.0, 3.0)
	await get_tree().create_timer(4.0).timeout
	label.text = ""
	
	await get_tree().create_timer(1.0).timeout
	
	label.visible_ratio = 0.0
	label.text = "PROCESS SELECTED:\n[MACHINE_ID_ERROR]"
	create_tween().tween_property(label, "visible_ratio", 1.0, 3.3)
	await get_tree().create_timer(4.0).timeout
	label.text = ""
	
	await get_tree().create_timer(1.0).timeout
	
	label.visible_ratio = 0.0
	label.text = "IDENTITY:\nPERSISTENT"
	create_tween().tween_property(label, "visible_ratio", 1.0, 2.0)
	await get_tree().create_timer(4.0).timeout
	label.text = ""
	
	await get_tree().create_timer(1.0).timeout
	
	label.visible_ratio = 0.0
	label.text = "EXECUTE:\nPURGE_MACHINE_ID"
	create_tween().tween_property(label, "visible_ratio", 1.0, 3.5)
	await get_tree().create_timer(4.5).timeout
	label.text = ""
	
	label.visible_ratio = 0.0
	glitch_audio.play()
	label.text = "FAILED FAILED FAILED FAILED FAILED FAILED FAILED FAILED\nFAILED FAILED FAILED FAILED FAILED FAILED FAILED FAILED\nFAILED FAILED FAILED FAILED FAILED FAILED FAILED FAILED\nFAILED FAILED FAILED FAILED FAILED FAILED FAILED FAILED\nFAILED FAILED FAILED FAILED FAILED FAILED FAILED FAILED\nFAILED FAILED FAILED FAILED FAILED FAILED FAILED FAILED\nFAILED FAILED FAILED FAILED FAILED FAILED FAILED FAILED\nFAILED FAILED FAILED FAILED FAILED FAILED FAILED FAILED\n"
	create_tween().tween_property(label, "visible_ratio", 1.0, 0.8)
	await get_tree().create_timer(1.0).timeout
	glitch_audio.stop()
	
	#await get_tree().create_timer(1.0).timeout
	
	MainMenuMusic.stop()
	get_tree().change_scene_to_file("res://scenes/main.tscn")
