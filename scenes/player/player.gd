class_name Player
extends CharacterBody2D

@onready var player_animations: AnimatedSprite2D = $PlayerAnimations
@onready var player_state_machine: Node = $StateMachine

func _ready() -> void:
	player_state_machine.init(self, player_animations)


func _unhandled_input(event: InputEvent) -> void:
	player_state_machine.process_input(event)


func _physics_process(delta: float) -> void:
	if HealthManager.is_zero() and !player_state_machine.current_state == $StateMachine/Dead:
		player_state_machine.change_state($StateMachine/Dead)
	
	player_state_machine.process_physics(delta)


func _process(delta: float) -> void:
	player_state_machine.process_frame(delta)


func new_game():
	if player_state_machine.current_state == $StateMachine/Dead:
		player_state_machine.change_state($StateMachine/Run)
