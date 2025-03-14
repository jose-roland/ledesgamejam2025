extends Control

@onready var inventory: Inv = preload("res://assets/resource/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var is_open := false

func _ready() -> void:
	update_slots()
	open()
	
func update_slots() -> void:
	for i in range(min(inventory.items.size(), slots.size())):
		slots[i].update(inventory.items[i])
	
func open() -> void:
	visible= true
	is_open = true
	
func close() -> void:
	visible = false
	is_open = false
