extends Node


## WAVE SPAWNER STATS
var enemies_to_spawn = 10
var spawn_mult = 1.18
var wave_delay = 60.0

## FLYER STATS
var flyer_speed = 200.0
var flyer_damage = 7.0
var flyer_damage_cd = 1.5 # seconds

var flyer_max_health = 100.0

var flyer_max_xp_drops = 3 # max total xp drops per kill

var flyer_charge_chance = 0.3 # chances on what to do
var flyer_fire_chance = 0.7

## GRUNT STATS
var grunt_speed = 300.0
var grunt_damage = 7.0
var grunt_damage_cd = 1.5 # seconds

var grunt_max_health = 100.0

var grunt_max_xp_drops = 3 # max total xp drops per kill

var grunt_charge_chance = 0.7 # chances on what to do
var grunt_fire_chance = 0.3

## CRAWLER STATS
var crawler_speed = 200.0
var crawler_damage = 15.0
var crawler_damage_cd = 1.5 # seconds

var crawler_max_health = 150.0

var crawler_max_xp_drops = 3 # max total xp drops per kill

var crawler_charge_chance = 1.0 # chances on what to do
var crawler_fire_chance = 0.0

## WIREBALL STATS
var wireball_speed = 50.0
var wireball_damage = 10.0
var wireball_damage_cd = 1.0 # seconds

var wireball_max_health = 175.0

var wireball_max_xp_drops = 5 # max total xp drops per kill

var wireball_charge_chance = 0.1 # chances on what to do
var wireball_fire_chance = 0.9

## CUBE STATS
var cube_speed = 75.0
var cube_damage = 20.0
var cube_child_damage = 10.0
var cube_damage_cd = 1.0 # seconds

var cube_max_health = 250.0
var cube_child_max_health = 25.0

var cube_max_xp_drops = 1 # max total xp drops per kill (for child only)
var cube_child_max_spawns = 4 # max amount of cubes to spawn

var cube_charge_chance = 0.7 # chances on what to do
var cube_fire_chance = 0.3
