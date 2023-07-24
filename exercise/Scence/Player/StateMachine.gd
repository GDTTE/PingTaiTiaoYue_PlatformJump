extends Node

class_name StateMachine

export var initial_state_path := NodePath() 

onready var current_state:Node = get_node(initial_state_path) 
#this signal is not used in this game,so it  can be deleted
signal transition_finished(state_name)

func _ready()->void:
	yield(owner,"ready")
	for child in get_children():
		child.state_machine = self 
				
	current_state.enter()
	
func _physics_process(delta:float)->void:
	current_state.physics_update(delta)
	
func transition_to(target_state_name:String)->void:
	if !has_node(target_state_name):
		print("目标状态" + target_state_name+  "不存在")
		return
	current_state.exit()
	current_state = get_node(target_state_name)
	current_state.enter()
	emit_signal("transition_finished",current_state.name)
	
	
	
	
