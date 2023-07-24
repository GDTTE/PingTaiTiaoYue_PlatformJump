extends StateCommonCode

onready var player:Node = get_node("/root/Player")


func enter()->void:
	state_machine.transition_to("idle")
	
func exit()->void:
	pass

func physics_update()->void:
	if !player.is_on_floor() && player.velocity.y >0:
		state_machine.transition_to("fall")
	var inputdirection_x:float = Input.get_action_strength("right")
