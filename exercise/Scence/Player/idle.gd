extends StateCommonCode



func enter()->void:
	player.animation_state.travel("idle")
	if player.is_on_floor():
		player.num_dashes = 1
	
	
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
		
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("jump")
		return
		
	if Input.is_action_just_pressed("attack"):
		state_machine.transition_to("attack")
		return
	
	if Input.is_action_just_pressed("dash"):
		if player.num_dashes >0:
			state_machine.transition_to("dash")
			return
	
	
	
