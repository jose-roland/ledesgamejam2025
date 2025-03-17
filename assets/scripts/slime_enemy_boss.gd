extends CharacterBody2D

var life = 8
var speed = 30
var direction = 1
var proj_speed = 60
var dano = 1
var projec = preload("res://assets/scenes/proj_slime.tscn")
var can_projec = true

@onready var ray_left = $RayCast_left
@onready var ray_right = $RayCast_right
@onready var anim = $AnimatedSprite2D
@onready var mira = $mira
@onready var visao = $visao_frente


func _process(delta: float) -> void:
	if ray_right.is_colliding():
		direction = -1
		anim.flip_h = true
		visao.target_position = Vector2(-140, 0)
		
	if ray_left.is_colliding():
		direction = 1
		anim.flip_h = false
		visao.target_position = Vector2(140, 0)
	position.x += speed * delta * direction
	check_collision_raycast()
	
func check_collision_raycast():
	var collider = visao.get_collider()
	if collider and collider.is_in_group("player"):
		ataque()
	
func ataque():
	if can_projec == true:
		can_projec = false
		var projec_instance = projec.instantiate() as Area2D
		projec_instance.position = mira.global_position
		projec_instance.direction = direction
		get_parent().add_child(projec_instance)
		await get_tree().create_timer(1.5).timeout
		can_projec = true
	

func levar_dano():
	life -= 1
	if life <= 0:
		queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	body.life -= 1
	pass # Replace with function body.
