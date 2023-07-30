extends StaticBody2D


onready var animationplayer = get_node("AnimationPlayer")
var playbackward = false


func open()->void:
	animationplayer.play("StoneGateOpen")
	playbackward = false




func close()->void:
	animationplayer.play_backwards("StoneGateOpen")
	playbackward = true


func _on_AnimationPlayer_animation_finished(anim_name):
	if playbackward == true:
		animationplayer.play("StoneGateIdle")
