extends Node2D

var ROCK_1 = preload("res://scenes/objects/rock_1.tscn")
var ROCK_2 = preload("res://scenes/objects/rock_2.tscn")
var ROCK_3 = preload("res://scenes/objects/rock_3.tscn")
var TREE_1 = preload("res://scenes/objects/tree_1.tscn")

var object_types = [ROCK_1]
var last_object = null
var parrent
# Called when the node enters the scene tree for the first time.
func _ready():
	parrent = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_object(obj, x, y):
	obj.position = Vector2(x,y)
	add_child(obj)
	#objects.append(obj)

func create_object():
	update_object_types()
	var obj_type = object_types[randi() % object_types.size()]
	var obj = obj_type.instantiate()
	var obj_height = obj.get_node("Sprite2D").texture.get_height()
	var obj_scale = obj.get_node("Sprite2D").scale
	
	var obj_x = parrent.screen_size.x + parrent.camera_2d.position.x + randf_range(500,1500)
	var obj_y = parrent.screen_size.y - parrent.ground_height - (obj_height * obj_scale.y / 2)
	
	last_object = obj
	add_object(obj,obj_x,obj_y)

func  spawn_object():
	if !parrent.is_game_running: return
	
	if is_last_obj_out_screen(parrent.screen_size, parrent.camera_2d.position):
		create_object()


func is_last_obj_out_screen(screen_size, camera_pos):
	return last_object == null or last_object.position.x < screen_size.x + camera_pos.x


func update_object_types():
	match parrent.difficulty:
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
