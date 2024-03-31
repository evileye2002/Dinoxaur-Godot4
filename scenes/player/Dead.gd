extends State

@onready var normal_col = $"../../NormalCol"
@onready var duck_col = $"../../DuckCol"

func enter() -> void:
	super()
	normal_col.disabled = true
	duck_col.disabled = true
	
	await get_tree().create_timer(1).timeout
	get_tree().paused = true

