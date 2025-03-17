extends Node2D

@export var item: InvItem

func _on_area_2d_body_entered(body: Node2D) -> void:
	$"../../Personagem/Audio_Moeda".play()
	body.collect(item)
	queue_free()
	pass # Replace with function body.
