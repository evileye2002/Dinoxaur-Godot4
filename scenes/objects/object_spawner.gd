extends Node2D

var ROCK_1 = preload("res://scenes/objects/rock_1.tscn")
var ROCK_2 = preload("res://scenes/objects/rock_2.tscn")
var ROCK_3 = preload("res://scenes/objects/rock_3.tscn")
var TREE_1 = preload("res://scenes/objects/tree_1.tscn")

@export_category("Object Spawner")
@export var X_SPAWN_RANGE = Vector2(500,1500)
@export var DIFFICULTY_MODIFIER: int = 50

var object_types = [ROCK_1]
var last_object = null
var parrent


# Called when the node enters the scene tree for the first time.
func _ready():
	parrent = get_parent()


func add_object(obj, x, y):
	obj.position = Vector2(x,y)
	add_child(obj)


func create_object():
	update_object_types()
	var obj_type = object_types[randi() % object_types.size()]
	var obj = obj_type.instantiate()
	var obj_height = obj.get_node("Sprite2D").texture.get_height()
	var obj_scale = obj.get_node("Sprite2D").scale
	
	var obj_x = GameManager.screen_size.x + parrent.camera_2d.position.x + random_pos()
	var obj_y = GameManager.screen_size.y - parrent.ground_height - (obj_height * obj_scale.y / 2)
	
	last_object = obj
	add_object(obj,obj_x,obj_y)


func random_pos():
	var increase_difficulty = GameManager.difficulty * DIFFICULTY_MODIFIER
	return randf_range(
		increase_difficulty + X_SPAWN_RANGE.x,
		increase_difficulty + X_SPAWN_RANGE.y)


func  spawn_object():
	if !GameManager.is_running: return
	
	if is_last_obj_out_screen(parrent.camera_2d.position):
		create_object()


func is_last_obj_out_screen(camera_pos):
	return last_object == null or last_object.position.x < GameManager.screen_size.x + camera_pos.x


func update_object_types():
	match GameManager.difficulty:
		0: if object_types.size() > 1:
			object_types = [ROCK_1]
		1: if object_types.size() < 3:
			object_types = [ROCK_1,ROCK_2,ROCK_2]
		2: if object_types.size() < 4:
			object_types = [ROCK_1,ROCK_2,ROCK_2,ROCK_3]
		3: if object_types.size() < 6:
			object_types = [ROCK_1,ROCK_2,ROCK_2,ROCK_2,ROCK_3,ROCK_3]

func new_game():
	for child in get_children():
		child.queue_free()
