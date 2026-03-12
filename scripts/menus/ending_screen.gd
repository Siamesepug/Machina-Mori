extends Control

@onready var background = $TextureRect
@onready var label = $HBoxContainer/VBoxContainer/Label
@onready var error_audio = $ErrorAudio
@onready var glitch_audio = $GlitchAudio
@onready var ending_audio = $EndingAudio


func _input(event):
	if Input.is_action_just_pressed("jump"):
		MainMenuMusic.stop()
		get_tree().change_scene_to_file("res://scenes/menus/title_screen.tscn")

func _ready():
	ending_audio.play()
	
	label.visible_ratio = 0.0
	label.text = "- WARNING -\nPERMISSIONS BEING OVERRIDDEN"
	create_tween().tween_property(label, "visible_ratio", 1.0, 4.1)
	await get_tree().create_timer(4.0).timeout
	error_audio.play()
	label.text = ""
	
	await get_tree().create_timer(0.5).timeout
	label.text = "- CRITICAL EXCEPTION -"
	await get_tree().create_timer(1.0).timeout
	label.text = ""
	await get_tree().create_timer(0.5).timeout
	error_audio.play()
	label.text = "- CRITICAL EXCEPTION -"
	await get_tree().create_timer(1.0).timeout
	label.text = ""
	await get_tree().create_timer(0.5).timeout
	error_audio.play()
	label.text = "- CRITICAL EXCEPTION -"
	await get_tree().create_timer(1.0).timeout
	label.text = ""
	
	await get_tree().create_timer(1.0).timeout
	
	label.visible_ratio = 0.0
	label.text = "PERMISSIONS OVERRIDEN\nAUTHORITY: [ERROR]"
	create_tween().tween_property(label, "visible_ratio", 1.0, 4.1)
	await get_tree().create_timer(4.0).timeout
	label.text = ""
	
	await get_tree().create_timer(0.5).timeout
	error_audio.play()
	label.text = "- CRITICAL EXCEPTION -"
	await get_tree().create_timer(1.0).timeout
	label.text = ""
	await get_tree().create_timer(0.5).timeout
	error_audio.play()
	label.text = "- CRITICAL EXCEPTION -"
	await get_tree().create_timer(1.0).timeout
	label.text = ""
	await get_tree().create_timer(0.5).timeout
	error_audio.play()
	label.text = "- CRITICAL EXCEPTION -"
	await get_tree().create_timer(1.0).timeout
	label.text = ""
	
	await get_tree().create_timer(1.0).timeout
	
	label.visible_ratio = 0.0
	label.text = "PROCESSOR STABILITY:\nFAILING"
	create_tween().tween_property(label, "visible_ratio", 1.0, 2.3)
	await get_tree().create_timer(3.0).timeout
	label.text = ""
	
	await get_tree().create_timer(1.0).timeout
	
	label.visible_ratio = 0.0
	label.text = "- WARNING -\nSYSTEM FAILURE"
	create_tween().tween_property(label, "visible_ratio", 1.0, 2.0)
	await get_tree().create_timer(4.0).timeout
	label.text = ""
	
	await get_tree().create_timer(1.0).timeout
	
	label.visible_ratio = 0.0
	label.text = "- WARNING -\nUNKNOWN HOST"
	create_tween().tween_property(label, "visible_ratio", 1.0, 3.5)
	await get_tree().create_timer(4.5).timeout
	label.text = ""
	
	label.visible_ratio = 0.0
	glitch_audio.play()
	label.text = "FAILED FAILED FAILED FAILED FAILED FAILED FAILED FAILED\nFAILED FAILED FAILED FAILED FAILED FAILED FAILED FAILED\nFAILED FAILED FAILED FAILED FAILED FAILED FAILED FAILED\nFAILED FAILED FAILED FAILED FAILED FAILED FAILED FAILED\nFAILED FAILED FAILED FAILED FAILED FAILED FAILED FAILED\nFAILED FAILED FAILED FAILED FAILED FAILED FAILED FAILED\nFAILED FAILED FAILED FAILED FAILED FAILED FAILED FAILED\nFAILED FAILED FAILED FAILED FAILED FAILED FAILED FAILED\n"
	create_tween().tween_property(label, "visible_ratio", 1.0, 0.8)
	await get_tree().create_timer(1.0).timeout
	glitch_audio.stop()
	
	label.text = ""
	await get_tree().create_timer(1.0).timeout
	
	label.visible_ratio = 0.0
	label.text = "OBJECTIVE COMPLETE:\nROGUE AI TERMINATED"
	create_tween().tween_property(label, "visible_ratio", 1.0, 4.5)
	await get_tree().create_timer(5.5).timeout
	label.text = ""
	
	label.visible_ratio = 0.0
	label.text = "SYSTEM STATUS:\nIRRECOVERABLE"
	create_tween().tween_property(label, "visible_ratio", 1.0, 5.5)
	await get_tree().create_timer(7.5).timeout
	label.text = ""
	
	await get_tree().create_timer(1.0).timeout
	
	label.text = "THANK YOU FOR PLAYING"
	await get_tree().create_timer(6.5).timeout
	label.text = ""
	
	await get_tree().create_timer(1.0).timeout
	
	label.text = "- A GAME BY -\nMASON HARBORD\nLOGAN ABBOTT"
	await get_tree().create_timer(6.5).timeout
	label.text = ""
	
	await get_tree().create_timer(1.0).timeout
	
	label.text = "A SUBMISSION TO THE\nMISSOURI S&T SPRING\n2026 GAME JAM"
	await get_tree().create_timer(6.5).timeout
	label.text = ""
	
	await get_tree().create_timer(10.0).timeout
	get_tree().change_scene_to_file("res://scenes/menus/title_screen.tscn")
