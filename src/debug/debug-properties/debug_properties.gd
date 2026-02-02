extends Control

func _ready() -> void:
	if !OS.has_feature("editor"): hide()
