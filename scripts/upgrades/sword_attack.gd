extends Area2D

@onready var player = $".."

@onready var damage = player.weapon_damage
@onready var size = player.weapon_size

@onready var collision_shape = $CollisionShape2D

func _ready():
	monitoring = false
	visible = false

func swing_sword():
	size = player.weapon_size
	damage = player.weapon_damage
	
	collision_shape.scale = Vector2(size, size)
	
	monitoring = true
	visible = true
	
	await get_tree().create_timer(0.2).timeout
	
	monitoring = false
	visible = false


func _on_sword_attack_body_entered(body: CharacterBody2D) -> void:
	body.take_damage(damage)
