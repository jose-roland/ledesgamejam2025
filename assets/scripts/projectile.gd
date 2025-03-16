extends Area2D

const SPEED := 100 

var projectile_speed := Vector2.ZERO
var direction := 1

func _process(delta: float) -> void:
	position.x += SPEED * delta * direction
	if direction < 0:
		$AnimatedSprite2D.set_flip_h(true)
	else:
		$AnimatedSprite2D.set_flip_h(false)

	

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("inimigos"):
		body.levar_dano()
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
