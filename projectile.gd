extends CharacterBody2D

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")

@export var speed : float = 400
var direction : Vector2
var damage : float

func _ready():
	expired_timer()

func _on_area_2d_body_entered(body: CharacterBody2D):
	if body == player: # NOTE : Bullets do 33% of normal damage
		SignalManager.damage_player.emit(damage * 0.33)

func _physics_process(delta):
	velocity = direction * speed
	move_and_slide()


func _on_destroy_self_body_entered(body):
	queue_free()

func expired_timer():
	await get_tree().create_timer(1.0).timeout
	
	queue_free()
