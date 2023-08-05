extends StateCommonCode



func enter()->void:
	player.animation_state.travel("attack")
	player.is_attacking = true
	player.current_velocity = Vector2.ZERO
	
	
func exit()->void:
	player.is_attacking = false
	player.get_node("HitboxPosition/Hitbox/CollisionShape2D").disabled = true



func physics_update(delta)->void:
	if !player.is_attacking:
		if player.is_on_floor():
			state_machine.transition_to("idle")
		else:
			state_machine.transition_to("fall")
