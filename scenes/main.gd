extends Node2D

const PLAYER_START_POS = Vector2(96,285)
const CAM_START_POS = Vector2(320,180)

@onready var player = $Player
@onready var camera_2d = $Camera2D
@onready var ground = $Ground
@onready var ui = $InGameUi
@onready var object_spawner = $ObjectSpawner
@onready var ground_height = $Ground.get_node("CollisionShape2D").shape.size.y

# Called when the node enters the scene tree for the first time.
func _ready():
	ui.restart.connect(new_game)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !GameManager.is_running:
		return
		
	if HealthManager.current_health > 0:
		run_game(delta)
	
	
func new_game():
	player.position = PLAYER_START_POS
	camera_2d.position = CAM_START_POS
	ground.position =  Vector2.ZERO
	
	object_spawner.new_game()
	player.new_game()
	
	GameManager.new_game()
	

func run_game(delta):
	GameManager.run_game(delta)
	
	player.position.x += GameManager.speed
	camera_2d.position.x += GameManager.speed
	
	if camera_2d.position.x - ground.position.x > GameManager.screen_size.x * 2:
		ground.position.x += GameManager.screen_size.x
		
	ui.update_score(GameManager.score)
	ui.check_game(GameManager.is_running)
	
	object_spawner.spawn_object()
	
func game_over():
	GameManager.game_over()
	ui.check_game(GameManager.is_running)
	
