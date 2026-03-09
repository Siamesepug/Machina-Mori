extends Camera2D


@export var decay = 0.8 # how quickly to stop shaking
@export var max_offset = Vector2(100,75) # maximum displacement in pixels
@export var max_roll = 0.0 # maximum rotation in radians
@export var noise : FastNoiseLite

var noise_y = 0 # value to move through noise

var shake_strength = 0.0
var shake_pwr = 3 # exponent to shake_strength [ 2 - 3 recmd]

func _ready():
	randomize()
	noise.seed = randi()

func shake_amount(amount : float):
	shake_strength = min(shake_strength + amount, 1.0)

func _process(delta):
	if shake_strength:
		shake_strength = max(shake_strength - decay * delta, 0)
		shake()

func shake():
	var amt = pow(shake_strength, shake_pwr)
	noise_y += 1
	rotation = max_roll * amt * noise.get_noise_2d(0, noise_y)
	offset.x = max_offset.x * amt * noise.get_noise_2d(1000, noise_y)
	offset.y = max_offset.y * amt * noise.get_noise_2d(2000, noise_y)
