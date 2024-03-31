extends State

@export
var duck_in_air_state: State
@export
var fall_state: State

@export
var jump_force: float = 1200

@onready var normal_col = $"../../NormalCol"
@onready var duck_col = $"../../DuckCol"

func enter() -> void:
	super()
	normal_col.disabled = false
	duck_col.disabled = true
	parent.velocity.y = -jump_force

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed('duck'):
		return duck_in_air_state
		
	return null

func process_physics(delta: float) -> State:
	gravity = base_gravity
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	if parent.velocity.y > 0:
		return fall_state
	
	return null
