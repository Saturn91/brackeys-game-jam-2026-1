class_name SettingsMenuController extends Node

@onready var fullscreen_checkbox: CheckBox = $"../UI/VBoxContainer/Body/Fields/Fullscreen"
@onready var music_slider: Slider = $"../UI/VBoxContainer/Body/Fields/MusicVolume"
@onready var sfx_slider: Slider = $"../UI/VBoxContainer/Body/Fields/SfxVolume"
@onready var main_menu_btn: Button = $"../UI/VBoxContainer/Button"

func _ready() -> void:
	
	fullscreen_checkbox.button_pressed = SettingsManager.singleton.fullscreen
	fullscreen_checkbox.toggled.connect(func(value): SettingsManager.singleton.fullscreen = value)
	
	init_slider(music_slider, SettingsManager.singleton.music_volume, func(value_changed): 
		if value_changed:
			SettingsManager.singleton.music_volume = music_slider.value)
			
	init_slider(sfx_slider, SettingsManager.singleton.sfx_volume, func(value_changed): 
		if value_changed:
			SettingsManager.singleton.sfx_volume = sfx_slider.value)
	
	UiUtils.connect_button_to_scene_load(main_menu_btn, load("res://src/main-menu/main_menu.tres"))

func init_slider(slider: Slider, value: float, on_change: Callable) -> void:
	slider.value = value
	slider.drag_ended.connect(on_change)
