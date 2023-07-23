extends Node

class_name StateMachine
var state_machine:StateMachine #注意，这不是变量，而是类的实例化
export var initial_state_path :NodePath #与get_node（“”）搭配使用
onready var current_state:Node = get_node("initial_state_path") #不是变量，是类的实例化
signal transition_finished(state_name)

func _ready()->void:
	yield(owner,"ready") #StateMachine节点的owner是谁？它何时发出ready信号？
	for child in get_children():
		child.state_machine = self #self是指StateMachine这个实例本身，类似于StateMachine state_mechine = new StateMachine()
				#如此，state_machine这个StateMachine型变量便拥有了StateMachine类的所有变量与方法
	current_state.enter() #enter()是节点current_state的方法，与该脚本没有关系
	
func _physics_process(delta:float)->void:
	current_state.physics_update(delta)
	
func transition_to(target_state_name:String)->void:
	if !has_node("target_state_name"):
		print("目标状态不存在")
		return
	current_state.exit()
	current_state = get_node("target_state_name")
	current_state.enter()
	emit_signal("transition_finished")
	
	
	
	
