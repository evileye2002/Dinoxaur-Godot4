extends Node

const START_SPEED: int = 300
const MAX_SPEED: int = 15
const SCORE_MODIFIER: int = 5
const SPEED_MODIFIER: int = 2000
const DIFFICULTY_MODIFIER: int = 4000
const MAX_DIFFICULTY: int = 4

var speed: float
var screen_size: Vector2
var score: int
var is_running: bool = false
var difficulty: int
var ground_height

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_window().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(difficulty)
	#print(speed)
	pass


func new_game():
	score = 0
	difficulty = 0
	HealthManager.new_game()
	get_tree().paused = false
	is_running = true
	
	
func game_over():
	get_tree().paused = true
	is_running = false


func update_difficulty():
	difficulty = score / DIFFICULTY_MODIFIER
	if difficulty > MAX_DIFFICULTY:
		difficulty = MAX_DIFFICULTY


func run_game(delta):
	speed = START_SPEED * delta + score / SPEED_MODIFIER
	if speed >= MAX_SPEED:
		speed = MAX_SPEED
	update_difficulty()
	score += 1
