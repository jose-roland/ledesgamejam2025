extends CharacterBody2D


const SPEED = 128.0
const JUMP_VELOCITY = -246.0
const DASH_SPEED = 412.0

var dash = false
var can_dash = true
var life = 3
var life_t = 3

@onready var dash_timer: Timer = $DashTimer
@onready var dash_timer_2: Timer = $DashTimer2
@onready var animated_sprite = $AnimatedSprite2D

@export var inventory: Inv

# -----------Variavel de Estado do player para Animações ------------
var current_state = player_states.MOVES

enum player_states{
	MOVES,
	HIT,
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
		player_states.MOVES:
			movimentos()
		player_states.HIT:
			hit()
		player_states.DEAD:
			dead()
	anim_updated()
	
	
func movimentos():
	# ------------- Sistema do DASH ---------------------------
	if Input.is_action_just_pressed("dash") && can_dash:
		dash = true
		can_dash = false
		dash_timer.start()
		dash_timer_2.start()
		# Movimentação do personagem
	var direction = Input.get_axis("move_left", "move_right")
	
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
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Teste para ver se o player perdeu vida, e se ele morreu.
	if life_t != life:
		life_t = life
		current_state = player_states.HIT
		if life <= 0:
			current_state = player_states.DEAD
			
	move_and_slide()
		
	
#---------------Função - Dano recebido por Player ------------------
func hit():
	move_and_slide()
	await get_tree().create_timer(0.4).timeout
	current_state = player_states.MOVES
#---------------Função - Morte do Player -------------------------
func dead():
	await get_tree().create_timer(0.4).timeout
	queue_free()
#-----------------Função - Animação do Player --------------------
func anim_updated():
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
