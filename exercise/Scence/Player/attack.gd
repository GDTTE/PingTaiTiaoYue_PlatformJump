extends StateCommonCode






func enter()->void:
	player.velocity = Vector2.ZERO
	player.is_attacking = true
	player.animation_state.travel("attack")
	
	
	
	
	
func exit()->void:
	pass




 
func physics_update(delta:float)->void:
#	player.apply_gravity(delta)
#
#	player.velocity = player.move_and_slide_with_snap(player.velocity,
#													  player.snap_vector,
#													Vector2.UP,
#													true,
#													4,
#													player.floor_max_angle,
#													false)
	
	if !player.is_attacking:
		state_machine.transition_to("idle")
		return
	
	
	
	
	
	
	
	
	
	
	
	
	
	