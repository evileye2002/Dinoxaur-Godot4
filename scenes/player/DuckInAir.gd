extends State

@export
var duck_run_state: State

@onready var normal_col = $"../../NormalCol"
@onready var duck_col = $"../../DuckCol"

var duck_in_air_speed : int = 30000

func enter() -> void:
	super()
	normal_col.disabled = true
	duck_col.disabled = false

func process_physics(delta: float) -> State:
	set_base_gravity(delta)
	
	if !parent.is_on_floor(): gravity = duck_in_air_speed
	else: 
		gravity = base_gravity
		return duck_run_state
	
	return null
