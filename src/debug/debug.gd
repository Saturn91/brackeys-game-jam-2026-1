class_name Debug extends Node

static var singleton: Debug

@onready var message_parent: Control = $"../UI/MarginContainer/VBoxContainer"

var _info_type: DebugMessageType = load("res://src/debug/message_types/info.tres")
var _warning_type: DebugMessageType = load("res://src/debug/message_types/warning.tres")
var _error_type: DebugMessageType = load("res://src/debug/message_types/error.tres")

var _template: PackedScene = load("res://src/debug/debug_message.tscn")

func _ready() -> void:
	singleton = self

func print(msg: String) -> void:
	print(msg)
	add_message(msg, _info_type)
	
func error(msg: String) -> void:
	print("error: " + msg)
	push_error(msg)
	add_message(msg, _error_type)
	
func warn(msg: String) -> void:
	print("warn: " + msg)
	add_message(msg, _warning_type)
	push_warning(msg)
	
func add_message(msg: String, type: DebugMessageType) -> void:
	var message: DebugMessage = _template.instantiate()
	message_parent.add_child(message)
	message.init(msg, type)
