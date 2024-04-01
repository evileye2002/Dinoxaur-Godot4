extends State

@export
var run_state: State
@export
var jump_state: State

@onready var normal_col = $"../../NormalCol"
@onready var duck_col = $"../../DuckCol"

func enter() -> void:
	super()
	normal_col.disabled = true
	duck_col.disabled = true
	
	await  get_tree().create_timer(0.5).timeout
	if !HealthManager.is_zero():
		get_parent().change_state(run_state)


func process_physics(delta: float) -> State:
	set_base_gravity(delta)
	
	return null
