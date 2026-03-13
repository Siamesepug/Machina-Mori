extends Node

# Holds the player's stats, which the player grabs
# to update it's personal variables.
# You can change these numbers from other scripts such as items/upgrades.
# Avoid directly changing the player's variables.

var current_weapon = "sword"
var weapon_damage = 50.0
var weapon_cd = 1.25 # seconds between slashes
var weapon_size = 1.0

var default_slash_color = Color.WHITE

var dash_damage = 80.0
var dash_cd = 3.0 # seconds
var dash_size = 1.0

var max_health = 100.0
var current_health = 100.0
var regen_cd = 3.0 # seconds before regen starts
var regen_rate = 1.0 # seconds between heals once active
var regen_amount = 2.0 # amount to heal

var xp_level = 0
var xp_progress = 0.0
var xp_gain = 10.0
var xp_per_level_increase = 10.0 # the increase in amount of xp needed to level up per level
var xp_healing = 0.0

var speed = 400.0
var jump_velocity = -1200.0
var dash_speed = 4.0

var level_duration = 300.0 # in seconds

## UNIQUE ITEM VARS
var has_beam = true
var beam_cd = 10.0 # seconds
var beam_duration = 2.5 # seconds , dont really change this, breaks audio timing

var has_double_attack = false

var has_nuke = false

## ELEMENT TIERS
var element_chance = 4 # a 1 in 4 chance of triggering an element

var fire_level = 1
var fire_mult = 10
var fire_damage = 5 # 5 damage over 10 stacks , 50 total

var frost_level = 1
var frost_mult = 30
var frost_damage = 1 # 1 damage over 40 stacks, 30 total
var frost_slow = 3 # slow duration

var acid_level = 1
var acid_mult = 15
var acid_damage = 3 # 3 damage over 15 stacks, 45 total

var electric_level = 1
var electric_mult = 3
var electric_damage = 15 # 15 damage over 3 stacks, 45 total
var electric_stun = 3 # stun duration

var bleed_level = 0

# Probably don't change this one, used to reset
# movement back to default after dash
var default_speed = 1.0

var glass_cannon = false

var max_jumps = 1

func reset_to_base():
	current_weapon = BaseAttributes.current_weapon
	weapon_damage = BaseAttributes.weapon_damage
	weapon_cd = BaseAttributes.weapon_cd
	weapon_size = BaseAttributes.weapon_size

	default_slash_color = BaseAttributes.default_slash_color

	dash_damage = BaseAttributes.dash_damage
	dash_cd = BaseAttributes.dash_cd
	dash_size = BaseAttributes.dash_size

	max_health = BaseAttributes.max_health
	current_health = BaseAttributes.current_health
	regen_cd = BaseAttributes.regen_cd
	regen_rate = BaseAttributes.regen_rate
	regen_amount = BaseAttributes.regen_amount

	xp_level = BaseAttributes.xp_level
	xp_progress = BaseAttributes.xp_progress
	xp_gain = BaseAttributes.xp_gain
	xp_per_level_increase = BaseAttributes.xp_per_level_increase
	xp_healing = BaseAttributes.xp_healing

	speed = BaseAttributes.speed
	jump_velocity = BaseAttributes.jump_velocity
	dash_speed = BaseAttributes.dash_speed

	level_duration = BaseAttributes.level_duration

	## UNIQUE ITEM VARS
	has_beam = BaseAttributes.has_beam
	beam_cd = BaseAttributes.beam_cd
	beam_duration = BaseAttributes.beam_duration

	has_double_attack = BaseAttributes.has_double_attack

	has_nuke = BaseAttributes.has_nuke

	## ELEMENT TIERS
	element_chance = BaseAttributes.element_chance

	fire_level = BaseAttributes.fire_level
	fire_mult = BaseAttributes.fire_mult
	fire_damage = BaseAttributes.fire_damage

	frost_level = BaseAttributes.frost_level
	frost_mult = BaseAttributes.frost_mult
	frost_damage = BaseAttributes.frost_damage
	frost_slow = BaseAttributes.frost_slow

	acid_level = BaseAttributes.acid_level
	acid_mult = BaseAttributes.acid_mult
	acid_damage = BaseAttributes.acid_damage

	electric_level = BaseAttributes.electric_level
	electric_mult = BaseAttributes.electric_mult
	electric_damage = BaseAttributes.electric_damage
	electric_stun = BaseAttributes.electric_stun

	bleed_level = BaseAttributes.bleed_level

	# Probably don't change this one, used to reset
	# movement back to default after dash
	default_speed = BaseAttributes.default_speed

	max_jumps = BaseAttributes.max_jumps
