class_name State
extends Node

@export
var animation_name: String

#var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
const base_gravity: int = 3400
var gravity: int
var animations: AnimatedSprite2D
var parent: CharacterBody2D

func enter() -> void:
	animations.play(animation_name)

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null

func set_base_gravity(delta: float):
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
