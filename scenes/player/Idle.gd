extends State

@export
var jump_state: State
@export
var fall_state: State

func enter() -> void:
	super()
	parent.velocity = Vector2.ZERO

func process_input(event: InputEvent) -> State:
	if Input.is_action_pressed('jump') and parent.is_on_floor():
		if !$"../..".get_parent().is_game_running:
			$"../..".get_parent().new_game()
		return jump_state
		
	return null

func process_physics(delta: float) -> State:
	gravity = base_gravity
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		return fall_state
	
	return null
