extends State

@export
var run_state: State

@onready var normal_col = $"../../NormalCol"
@onready var duck_col = $"../../DuckCol"

func enter() -> void:
	super()
	normal_col.disabled = true
	duck_col.disabled = false

func process_physics(delta: float) -> State:
	gravity = base_gravity
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	if !Input.is_action_pressed('duck'):
		return run_state
	
	return null
