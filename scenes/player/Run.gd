extends State

@export
var duck_run_state: State
@export
var jump_state: State
@export
var fall_state: State

@onready var normal_col = $"../../NormalCol"
@onready var duck_col = $"../../DuckCol"

func enter() -> void:
	super()
	normal_col.disabled = false
	duck_col.disabled = true

func process_input(event: InputEvent) -> State:
	if Input.is_action_pressed('jump') and parent.is_on_floor():
		return jump_state
		
	if Input.is_action_just_pressed('duck'):
		return duck_run_state
		
	return null

func process_physics(delta: float) -> State:
	set_base_gravity(delta)
	
	if parent.velocity.y != 0:
		return fall_state
	
	return null
