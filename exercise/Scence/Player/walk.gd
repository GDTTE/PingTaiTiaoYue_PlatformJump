extends StateCommonCode




func enter()->void:
	player.animation_state.travel("walk")
	
	
func exit()->void:
	pass
	
func physics_update(delta:float)->void:
	player.apply_gravity(delta)
	player.velocity = player.move_and_slide_with_snap(player.velocity,
													  player.snap_vector,
													  Vector2.UP,
													  true,
													  4,
													  player.floor_max_angle,
													  false)
#	player.velocity = player.move_and_slide(player.velocity,
#	Vector2.UP,true,4,player.floor_max_angle,true)

	var inputdirection_x:float =(
		Input.get_action_strength("right")-Input.get_action_strength("left")
	)
	if is_equal_approx(inputdirection_x,0.0):
		state_machine.transition_to("idle")
		return

	player.update_direction(inputdirection_x)
	player.velocity.x = player.walk_speed * inputdirection_x
	
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("jump")
		return
	if Input.is_action_just_pressed("attack"):
		state_machine.transition_to("attack")
		return
		
	if Input.is_action_just_pressed("dash"):
		if player.num_dashes > 0:
			state_machine.transition_to("dash")
			return
			
#	if player.get_slide_count()>0:
#		for i in player.get_slide_count():
#			var collision = player.get_slide_collision(i)
#			var collider = collision.collider
#			if collider is SpikePit:
#				state_machine.transition_to("death")
