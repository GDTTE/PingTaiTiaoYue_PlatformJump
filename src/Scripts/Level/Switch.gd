extends Area2D



var switch_is_close = true

onready var animationsprite = get_node("AnimatedSprite")
onready var stonegate = get_node("StoneGate")


func _ready():
	print("Switch is ready")




func _on_Switch_area_entered(area:Area2D):
	print("area entered")
	if switch_is_close == true:
		switch_is_close = false
		animationsprite.play("right_switch_open")
		stonegate.open()
	else:
		switch_is_close = true
		animationsprite.play("left_switch_close")
		stonegate.close()

