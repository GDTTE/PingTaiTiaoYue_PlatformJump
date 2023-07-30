extends IComponent
class_name IActor

var body: KinematicBody2D = null setget set_body

# set the body which under controll
# 设定行动的主体
func set_body(b: KinematicBody2D) -> void: body = b

# do sonething
# 实施行动
func act(args): pass

# conveying willingness to take action
# 传递行动意愿（用于控制身体行动）
func expect(args): pass
