extends StaticBody2D

@export var boost_strength : float = -1500

func _on_area_2d_body_entered(body : CharacterBody2D):
	_boost_player(body)

func _boost_player(player):
	player.velocity.y = boost_strength
