extends CanvasLayer

@onready var label = $Label

func _ready():
	label.modulate.a = 0.0
	
	var tween = create_tween()
	
	# FADE IN
	tween.tween_property(label, "modulate:a", 1.0, 4.0)
	
	tween.tween_interval(2.0)
	
	# FADE OUT
	tween.tween_property(label, "modulate:a", 0.0, 2.0)
	await tween.finished
	
	queue_free()
