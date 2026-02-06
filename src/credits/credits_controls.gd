class_name CreditControls extends Node

@export var credits: Array[CreditsField] = []

@onready var main_menu_button: Button = $"../UI/VBoxContainer/Button"
@onready var label_parent: Control = $"../UI/VBoxContainer/Body/Labels"
@onready var value_parent: Control = $"../UI/VBoxContainer/Body/Values"

func _ready() -> void:
	UiUtils.connect_button_to_scene_load(main_menu_button, load("res://src/main-menu/main_menu.tres"))
	
	for credit in credits:
		var label_instance = Label.new()
		var value_instance
		if credit.link.is_empty():
			value_instance = Label.new()
		else:
			value_instance = LinkButton.new()
			value_instance.underline = LinkButton.UNDERLINE_MODE_ON_HOVER
			value_instance.uri = credit.link
			
		label_instance.text = credit.label + ":"
		value_instance.text = credit.value
		
		label_parent.add_child(label_instance)
		value_parent.add_child(value_instance)
