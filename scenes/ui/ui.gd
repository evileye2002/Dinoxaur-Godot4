extends CanvasLayer

@onready var in_game_top = $MarginContainer/InGameTop
@onready var game_over = $MarginContainer/GameOver
@onready var HEART = preload("res://scenes/ui/heart.tscn")

signal restart()

# Called when the node enters the scene tree for the first time.
func _ready():
	HealthManager.update_heart.connect(_on_update_heart)
	new_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func update_score(score):
	in_game_top.get_node("Score/ScoreValue").text = str(score)
	pass

func check_game(is_running):
	if is_running: 
		in_game_top.show()
		game_over.hide()
	else: 
		in_game_top.hide()
		game_over.show()
		
		
func _on_update_heart(current_health):
	var health_bar_childs = in_game_top.get_node("HealthBar").get_children()
	health_bar_childs[current_health].play("decrease")


func _on_button_pressed():
	new_game()
	emit_signal("restart")


func new_game():
	var health_bar = in_game_top.get_node("HealthBar")
	for child in health_bar.get_children():
		child.queue_free()
	
	for i in range(HealthManager.max_health):
		var heart = HEART.instantiate()
		
		if i > 0:
			heart.position.x = 38 * i
		health_bar.add_child(heart)

