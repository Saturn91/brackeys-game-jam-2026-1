class_name DebugMessage extends ColorRect

@export var types: Array[DebugMessageType] = []

@onready var label = $HBoxContainer/Label
@onready var icon: TextureRect = $HBoxContainer/TextureRect
@onready var timer: Timer = $ClearTimer

func init(msg: String, type: DebugMessageType) -> void:
	label.text = msg
	icon.texture = type.icon
	color = type.color
	timer.wait_time = type.delay
	timer.start()
	timer.timeout.connect(func(): queue_free())
	
