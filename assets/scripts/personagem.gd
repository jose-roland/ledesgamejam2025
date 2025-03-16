extends CharacterBody2D


const SPEED = 128.0
const JUMP_VELOCITY = -246.0
const DASH_SPEED = 412.0
const spell = preload("res://assets/scenes/projectile.tscn")

var can_dash = true
var can_coyote_jump := false
var can_shoot = true
var dash = false
var life = 8
var life_t = 8

@onready var dash_timer: Timer = $DashTimer
@onready var dash_timer_2: Timer = $DashTimer2
@onready var animated_sprite = $AnimatedSprite2D

@export var inventory: Inv

@onready var project_position = $project_position

# -----------Variavel de Estado do player para Animações ------------
var current_state = player_states.MOVES

enum player_states{
	MOVES,
	HIT,
	SPELL,
	DEAD
}
# --------------Função Principal -------------------------------
func _physics_process(delta: float) -> void:
	# Adição da Gravidade
	if not is_on_floor():
		if dash:
			velocity += get_gravity() * delta / 1.6 # Caso esteja no dash, a gravidade será menor. Assim o dash será quase reto.
		else:
			velocity += get_gravity() * delta


	# Analisa em que estado o Player esta.	
	match current_state:
		player_states.SPELL:
			power()
		player_states.MOVES:
			movimentos()
		player_states.HIT:
			hit()
		player_states.DEAD:
			dead()
	anim_updated()
		
func movimentos():
	if Input.is_action_just_pressed("spell"):
		current_state = player_states.SPELL
	
	# ------------- Sistema do DASH ---------------------------
	if Input.is_action_just_pressed("dash") && can_dash:
		dash = true
		can_dash = false
		dash_timer.start()
		dash_timer_2.start()
	
	# Movimentação do personagem
	var direction = Input.get_axis("move_left", "move_right")

	if Input.is_action_pressed("move_left"):
		if sign(project_position.position.x) == 1:
			project_position.position.x *= -1
			
	if Input.is_action_pressed("move_right"):
		if sign(project_position.position.x) == -1:
			project_position.position.x *= -1
	
	if direction:
		if dash:
			velocity.x = direction * DASH_SPEED
		else:
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	#----------------------------------------------------------
	# Mudança de Animação da Direção do movimento
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	# Ação de Pular
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() || can_coyote_jump:
			velocity.y = JUMP_VELOCITY
			
			if can_coyote_jump:
				can_coyote_jump = false

	# Teste para ver se o player perdeu vida, e se ele morreu.
	if life_t != life:
		life_t = life
		current_state = player_states.HIT
		if life <= 0:
			current_state = player_states.DEAD

	var was_on_floor = is_on_floor()
	
	move_and_slide()
	
	if was_on_floor && !is_on_floor() && velocity.y >= 0:
		can_coyote_jump = true
		coyote_timer.start()

func _on_coyote_timer_timeout() -> void:
	can_coyote_jump = false

func power():
	if not can_shoot:
		return
	can_shoot = false
	
	var power_instance = spell.instantiate() as Area2D
	var direction = 1 if sign(project_position.position.x) == 1 else -1
	power_instance.set("direction", direction)
	power_instance.position = project_position.global_position
	get_parent().add_child(power_instance)
	
	await animated_sprite.animation_finished
	can_shoot = true
	current_state = player_states.MOVES
	

#---------------Função - Dano recebido por Player ------------------
func hit():
	await get_tree().create_timer(0.6).timeout

	current_state = player_states.MOVES
#---------------Função - Morte do Player -------------------------
func dead():
	await get_tree().create_timer(0.6).timeout
	queue_free()
#-----------------Função - Animação do Player --------------------
func anim_updated():
	if current_state == player_states.SPELL:
		animated_sprite.play("spell")
	if current_state == player_states.MOVES:
		if velocity.x == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	if current_state == player_states.HIT:
		animated_sprite.play("hit")

	if current_state ==player_states.DEAD:
		animated_sprite.play("hit")

#---------------Funções - Timer do uso do DASH -------------------
func _on_dash_timer_timeout() -> void:
	dash = false
func _on_dash_timer_2_timeout() -> void:
	can_dash = true

func collect(item):
	inventory.insert(item)