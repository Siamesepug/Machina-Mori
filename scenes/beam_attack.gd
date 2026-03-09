extends Area2D

@onready var player = $"../.."

@onready var damage = player.dash_damage
@onready var size = player.dash_size
@onready var camera = $"../../Camera2D"

@onready var collision_shape = $CollisionShape2D
#@onready var beam_sprite = $Sprite2D

func _ready():
	monitoring = false
	visible = false

func is_firing():
	size = player.dash_size
	collision_shape.scale = Vector2(size, size)
	
	monitoring = true
	visible = true
	
	var temp_decay = camera.decay
	camera.decay /= 40
	
	camera.shake_amount(1.0)
	# HOW LONG BEAM LASTS, NEED TO CHANGE
	await get_tree().create_timer(1.0).timeout
	
	camera.decay = temp_decay
	monitoring = false
	visible = false

func _on_dash_attack_body_entered(body: CharacterBody2D) -> void:
	body.take_damage(damage)
