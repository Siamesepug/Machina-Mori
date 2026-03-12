extends CharacterBody2D

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")

@export var speed : float = 400
var direction : Vector2
var damage : float

func _on_area_2d_body_entered(body: CharacterBody2D):
	if body == player:
		SignalManager.damage_player.emit(damage)

func _physics_process(delta):
	velocity = direction * speed
	move_and_slide()


func _on_destroy_self_body_entered(body):
	queue_free()
