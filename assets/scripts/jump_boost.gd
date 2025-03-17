extends Node2D

@export var item: InvItem

func _on_area_2d_body_entered(body: Node2D) -> void:
	body.collect(item)
	body.increase_jump_velocity(16.0)
	queue_free()
