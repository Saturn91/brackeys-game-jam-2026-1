class_name SettingsMenuController extends Node

@onready var fullscreen_checkbox: CheckBox = $"../UI/VBoxContainer/Body/Fields/Fullscreen"
@onready var music_slider: Slider = $"../UI/VBoxContainer/Body/Fields/MusicVolume"
@onready var sfx_slider: Slider = $"../UI/VBoxContainer/Body/Fields/SfxVolume"
@onready var ui_slider: Slider = $"../UI/VBoxContainer/Body/Fields/UIScale"
@onready var main_menu_btn: Button = $"../UI/VBoxContainer/Button"

func _ready() -> void:
	fullscreen_checkbox.button_pressed = SettingsManager.fullscreen
	fullscreen_checkbox.toggled.connect(func(value): SettingsManager.fullscreen = value)
	
	music_slider.value = SettingsManager.music_volume
	music_slider.value_changed.connect(func(value_changed):
		if value_changed:
			SettingsManager.music_volume = music_slider.value
		)
	
	sfx_slider.value = SettingsManager.sfx_volume
	sfx_slider.drag_ended.connect(func(value_changed: float): 
		if value_changed:
			GlobalSound.singleton.play("UiPlop")
			SettingsManager.sfx_volume = sfx_slider.value
	)	
	
	ui_slider.value = SettingsManager.ui_scale
	ui_slider.drag_ended.connect(func(value_changed: float): 
		if value_changed:
			SettingsManager.ui_scale = ui_slider.value
	)
	
	UiUtils.connect_button_to_scene_load(main_menu_btn, load("res://src/main-menu/main_menu.tres"))
