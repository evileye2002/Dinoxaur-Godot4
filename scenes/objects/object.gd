class_name Obj
extends Area2D

func _on_body_entered(body):
	if body.is_in_group("Player"):
		var hurt_state = body.get_node("StateMachine/Hurt")
		body.player_state_machine.change_state(hurt_state)
		HealthManager.decrease_health(1)


func _on_timer_timeout():
	queue_free()
