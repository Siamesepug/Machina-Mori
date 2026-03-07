extends RigidBody2D

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")

var xp_amount = PlayerAttributes.xp_gain

func _process(delta):
	#rotation += 0.1
	pass

func _on_pickup_range_body_entered(body):
	if body != player:
		return # Do nothing
	
	xp_amount = PlayerAttributes.xp_gain
	
	SignalManager.xp_gained.emit(xp_amount)
	queue_free()
