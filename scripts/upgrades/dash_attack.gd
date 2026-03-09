extends Area2D

@onready var player = $".."

@onready var damage = player.dash_damage
@onready var size = player.dash_size

@onready var collision_shape = $CollisionShape2D

func _ready():
	monitoring = false
	visible = false

func is_dashing():
	size = player.dash_size
	damage = player.dash_damage
	
	collision_shape.scale = Vector2(size, size)
	
	monitoring = true
	visible = true
	
	await get_tree().create_timer(0.2).timeout
	
	monitoring = false
	visible = false

func _on_dash_attack_body_entered(body: CharacterBody2D) -> void:
	body.take_damage(damage)
