extends KinematicBody2D
class_name Entity

var velocity: Vector2 = Vector2.ZERO


func _ready() -> void:
	for child in get_children():
		if child is IController:
			controller = child.new()
			return



func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	controller.physics_process(delta)
	print(controller)
	update_flip()



func update_flip(x = velocity.x) -> void:
	if x > 0 : get_node("Sprite").flip_h = false
	elif x < 0 : get_node("Sprite").flip_h = true
