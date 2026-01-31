class_name Debug extends Node

static var singleton: Debug

func _ready() -> void:
	singleton = self

func print(msg: String) -> void:
	print(msg)
	
func error(msg: String) -> void:
	print("error: " + msg)
	push_error(msg)
	
func warn(msg: String) -> void:
	print("warn: " + msg)
	push_warning(msg)
