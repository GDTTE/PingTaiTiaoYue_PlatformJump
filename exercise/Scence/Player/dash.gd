extends StateCommonCode






func enter()->void:
	player.is_dashing = true
	
	player.num_dashes -= 1
	player.animation_state.travel("dash")
	



func exit()->void:
	pass



func physics_update(delta:float):
	player.velocity.y = 0
	player.velocity = player.move_and_slide_with_snap(player.velocity,
													player.snap_vector,
													Vector2.UP,
													true,
													4,
													player.floor_max_angle,
													false)
	
	if player.direction == "right":
		player.velocity.x = player.dash_speed
	else:
		player.velocity.x = -player.dash_speed
	
	if !player.is_dashing:
		state_machine.transition_to("idle")

	if player.get_slide_count()>0:
		for i in player.get_slide_count():
			var collision = player.get_slide_collision(i)
			var collider = collision.collider
			if collider is SpikePit:
				state_machine.transition_to("death")
