extends StaticBody2D

var final_prompt = load("res://scenes/menus/final_prompt.tscn")
var prompt = null

func _on_prompt_area_body_entered(body: CharacterBody2D):
	prompt = final_prompt.instantiate()
	get_parent().add_child(prompt)

func _on_press_area_body_entered(body: CharacterBody2D):
	prompt.queue_free()
	get_tree().change_scene_to_file("res://scenes/menus/ending_screen.tscn")
