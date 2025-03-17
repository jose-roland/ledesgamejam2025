extends Area2D

var on_door = false

func _on_body_entered(body: Node2D) -> void:
	on_door = true

func _on_body_exited(body: Node2D) -> void:
	on_door = false

func _process(delta: float) -> void:
	if on_door == true and Input.is_action_just_pressed("Entrar na porta"):
		$Audio_Porta.play()
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_file("res://assets/scenes/Nivel_2.tscn")
