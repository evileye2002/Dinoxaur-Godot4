extends Node2D

const PLAYER_START_POS = Vector2(96,285)
const CAM_START_POS = Vector2(320,180)
const START_SPEED : int = 300
const MAX_SPEED : int = 15
const SCORE_MODIFIER : int = 5
const SPEED_MODIFIER : int = 2000
const DIFFICULTY_MODIFIER : int = 4000
const MAX_DIFFICULTY : int = 4
var game_speed : float
var screen_size : Vector2
var score : int
var is_game_running : bool = false
var difficulty
var ground_height

@onready var player = $Player
@onready var camera_2d = $Camera2D
@onready var ground = $Ground
@onready var ui = $Ui
@onready var object_spawner = $ObjectSpawner
@onready var ground_col = $Ground.get_node("CollisionShape2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_window().size
	ground_height =ground_col.shape.size.y
	new_game()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !is_game_running:
		if Input.is_action_just_pressed("jump"):
			is_game_running = true
			new_game()
		return
		
	if  HealthManager.current_health > 0:
		run_game(delta)
	
	
func new_game():
	player.position = PLAYER_START_POS
	camera_2d.position = CAM_START_POS
	ground.position =  Vector2.ZERO
	score = 0
	difficulty = 0
	get_tree().paused = false
	ui.run_game(is_game_running)
	
func update_difficulty():
	difficulty = score / DIFFICULTY_MODIFIER
	if difficulty > MAX_DIFFICULTY:
		difficulty = MAX_DIFFICULTY

func run_game(delta):
	game_speed = START_SPEED * delta + score / SPEED_MODIFIER
	if game_speed >= MAX_SPEED:
		game_speed = MAX_SPEED
	update_difficulty()
	
	player.position.x += game_speed
	camera_2d.position.x += game_speed
	score += 1
	
	if camera_2d.position.x - ground.position.x > screen_size.x * 2.2:
		ground.position.x += screen_size.x
	ui.update_score(score)
	ui.run_game(is_game_running)
	
	object_spawner.spawn_object()
	

