extends Control

# Displays 3 random items for the player
# to choose when levelling up

@export var item_list: Array[PackedScene] = []

@onready var slot1 = $VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer
@onready var slot2 = $VBoxContainer/HBoxContainer/VBoxContainer2/PanelContainer2

var slots = 2

func _ready():
	hide()
	SignalManager.level_up.connect(show_menu)

func show_menu():
	show()
	get_tree().paused = true
	generate_random_items()

func _input(event):
	if Input.is_action_just_pressed("debug_grab"):
		hide()

func generate_random_items():
	# Takes the list of items, makes a copy, shuffles the copy,
	# and chooses the first few items in the new list
	
	var item_pool = item_list.duplicate()
	item_pool.shuffle()
	
	var selected_item = item_pool[0]
	var item_instance = selected_item.instantiate()
	slot1.add_child(item_instance)
	
	selected_item = item_pool[1]
	item_instance = selected_item.instantiate()
	slot2.add_child(item_instance)
