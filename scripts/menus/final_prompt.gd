extends CanvasLayer

@onready var label = $VBoxContainer

func _ready():
	label.modulate.a = 0.0
	
	var tween = create_tween()
	
	# FADE IN
	tween.tween_property(label, "modulate:a", 1.0, 3.0)
