extends Control

func _ready() -> void:
	if !OS.has_feature("editor"): hide()

func _process(delta: float) -> void:
	if Input.is_action_just_released("toggle_debug"):
		if visible: hide()
		else: show()
