class_name Module extends Node2D

signal on_unload

func unload() -> void:
	on_unload.emit
	queue_free()
