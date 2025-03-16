extends Control

@onready var inventory: Inv = preload("res://assets/resource/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var is_open := false

func _ready() -> void:
	inventory.update.connect(update_slots)
	update_slots()
	open()
	
func update_slots():
	for i in range(min(inventory.slots.size(), slots.size())):
		slots[i].update(inventory.slots[i])
	
func open() -> void:
	visible= true
	is_open = true
	
func close() -> void:
	visible = false
	is_open = false
