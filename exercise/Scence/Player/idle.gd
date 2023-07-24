extends StateCommonCode



func enter()->void:
	player.animation_state.travel("idle")
	
	
func exit()->void:
	pass


func physics_update(delta:float)->void:
	player.apply_gravity(delta)
	player.velocity = player.move_and_slide_with_snap(player.velocity,
													player.snap_vector,
													Vector2.UP,
													true,
													player.floor_max_angle,
													false)
													
													
													
	if !player.is_on_floor() && player.velocity.y >0:
		state_machine.transition_to("fall")
		return
	
	
	if Input.is_action_pressed("right")||Input.is_action_pressed("left"):
		state_machine.transition_to("walk")
		return
		
		
	
	
