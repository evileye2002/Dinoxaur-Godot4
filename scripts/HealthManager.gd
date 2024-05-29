extends Node

var max_health : int = 1
var current_health : int

signal  update_heart(current_health)

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func decrease_health(amount : int):
	current_health -= amount
	
	if current_health < 0:
		current_health = 0
	emit_signal("update_heart",current_health)
	
func increase_health(amount : int):
	current_health += amount
	
	if current_health > max_health:
		current_health = max_health


func  is_zero():
	return current_health == 0


func new_game():
	current_health = max_health
