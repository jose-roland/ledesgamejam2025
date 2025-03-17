extends CharacterBody2D

var life = 5
var speed = 30
var direction = 1

@onready var ray_left = $RayCast_left
@onready var ray_right = $RayCast_right
@onready var anim = $AnimatedSprite2D

func _process(delta: float) -> void:
	if ray_right.is_colliding():
		direction = -1
		anim.flip_h = true
	if ray_left.is_colliding():
		direction = 1
		anim.flip_h = false
	position.x += speed * delta * direction
	pass

func levar_dano():
	life -= 1
	if life <= 0:
		queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	body.life -= 1
	pass # Replace with function body.
