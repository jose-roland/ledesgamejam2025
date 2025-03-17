extends Node2D

@export var item: InvItem
@onready var audio_moeda: AudioStreamPlayer2D = $"../../Personagem/Audio_Moeda"

func _on_area_2d_body_entered(body: Node2D) -> void:
	audio_moeda.play()
	body.collect(item)
	queue_free()
	pass # Replace with function body.
