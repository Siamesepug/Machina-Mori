extends Node

# Holds the player's stats, which the player grabs
# to update it's personal variables.
# You can change these numbers from other scripts such as items/upgrades.
# Avoid directly changing the player's variables.

var current_weapon = "sword"
var weapon_damage = 50.0
var weapon_cd = 1.25 # seconds between slashes
var weapon_size = 1.0

var default_slash_color = Color8(123, 0, 0)

var dash_damage = 80.0
var dash_cd = 3.0 # seconds
var dash_size = 1.0

var max_health = 1000000.0
var current_health = 1000000.0
var regen_cd = 3.0 # seconds before regen starts
var regen_rate = 2.0 # seconds between heals once active

var xp_level = 0
var xp_progress = 0.0
var xp_gain = 10.0
var xp_per_level_increase = 10.0 # the increase in amount of xp needed to level up per level

var speed = 400.0
var jump_velocity = -1200.0
var dash_speed = 4.0

var level_duration = 300.0 # in seconds

# Probably don't change this one, used to reset
# movement back to default after dash
var default_speed = 1.0

var max_jumps = 1
