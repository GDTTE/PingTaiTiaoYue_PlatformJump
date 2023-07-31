extends IComponent
class_name IController

var controlled: KinematicBody2D
var actors := []
var sensors := []

func _init(body: KinematicBody2D).() -> void: 
	controlled = body
	
func set_body(body: KinematicBody2D) -> void: 
	controlled = body

func add_component(comp: IComponent) -> void:
	if comp is IActor: actors.append((comp as IActor))
	elif comp is ISensor: sensors.append((comp as ISensor))
	
	if is_instance_valid(actors[0]): (actors[0] as IActor).set_body(controlled)

# 响应输入事件
func input(event: InputEvent) -> void: 
	pass

# 帧事件
func process(delta: float) -> void: 
	pass

# 物理帧事件
func physics_process(delta) -> void:
	pass
