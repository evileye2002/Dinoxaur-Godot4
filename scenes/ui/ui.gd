extends CanvasLayer

@onready var score_value = $MarginContainer/InGameTop.get_node("Score/ScoreValue")
@onready var health_bar = $MarginContainer/InGameTop.get_node("HealthBar")
@onready var HEART = preload("res://scenes/ui/heart.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var health_bar_size = health_bar.get_children().size()
	
	if !health_bar_size < HealthManager.max_health:
		return
	
	for i in range(HealthManager.max_health - health_bar_size):
		var heart = HEART.instantiate()
		
		if i > 0:
			heart.position.x = 38 * i
		health_bar.add_child(heart)

	HealthManager.update_heart.connect(_on_update_heart)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func update_score(score):
	score_value.text = str(score)

func run_game(is_running):
	if is_running: $MarginContainer/InGameTop.show()
	else: $MarginContainer/InGameTop.hide()

func _on_update_heart(current_health):
	var health_bar_childs = health_bar.get_children()
	health_bar_childs[current_health].play("decrease")
