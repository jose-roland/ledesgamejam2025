extends Area2D


const SPEED := 100 

var projectile_speed := Vector2.ZERO
@export var direction := 1


func _process(delta: float) -> void:
	position.x += SPEED * delta * direction
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.levar_dano()
	queue_free()
