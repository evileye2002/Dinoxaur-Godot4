extends State

@export
var run_state: State
@export
var duck_in_air_state: State

@onready var normal_col = $"../../NormalCol"
@onready var duck_col = $"../../DuckCol"

func enter() -> void:
	super()
	normal_col.disabled = false
	duck_col.disabled = true

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed('duck'):
		return duck_in_air_state
		
	return null

func process_physics(delta: float) -> State:
	gravity = base_gravity
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	if parent.is_on_floor():
		return run_state
		
	return null
