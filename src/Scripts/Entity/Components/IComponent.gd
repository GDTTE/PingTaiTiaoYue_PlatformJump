extends Node
class_name IComponent

var capability_tag := "[请设置能力描述]" setget set_capability_tag, get_capability_tag

func set_capability_tag(tag) -> void: capability_tag = tag
func get_capability_tag() -> String: return capability_tag 


func add_to_list(a = []):
	if a == []: return
	(a as Array).append(self)
