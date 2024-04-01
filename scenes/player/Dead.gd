extends State

@onready var normal_col = $"../../NormalCol"
@onready var duck_col = $"../../DuckCol"

var dead_gravity : int = 600

func enter() -> void:
	super()
	normal_col.disabled = true
	duck_col.disabled = true
	
	await get_tree().create_timer(1).timeout
	$"../..".get_parent().game_over()


#func process_physics(delta: float) -> State:
	#parent.velocity.y += dead_gravity * delta
	#parent.move_and_slide()
	#
	#return null
