extends CharacterBody2D


const SPEED = 128.0
const JUMP_VELOCITY = -256.0
const DASH_SPEED = 512.0
var dash = false
var can_dash = true

@onready var dash_timer: Timer = $DashTimer
@onready var dash_timer_2: Timer = $DashTimer2


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_pressed("dash") && can_dash:
		dash = true
		can_dash = false
		dash_timer.start()
		dash_timer_2.start()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		if dash:
			velocity.x = direction * DASH_SPEED
		else:
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_dash_timer_timeout() -> void:
	dash = false



func _on_dash_timer_2_timeout() -> void:
	can_dash = true
