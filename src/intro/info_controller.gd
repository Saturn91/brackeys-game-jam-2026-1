class_name IntroController extends Node

@export var intro_delay_s: float = 3.0

func _ready() -> void:
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = intro_delay_s
	timer.timeout.connect(func():
		ModulManager.singleton.load_module("main-menu")
	)	
	timer.start()
