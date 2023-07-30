extends KinematicBody2D
class_name Entity

var velocity: Vector2 = Vector2.ZERO

var controller = AIController.new(self)

func _ready() -> void:
	pass


func _input(event: InputEvent) -> void:
	controller.input(event)


func _process(delta: float) -> void:
	controller.process(delta)
	updata_flip()


func _physics_process(delta: float) -> void:
	velocity = controller.physics_process(delta)


func updata_flip(x = velocity.x) -> void:
	if x > 0 : $AnimatedSprite.flip_h = false
	elif x < 0 : $AnimatedSprite.flip_h = true
