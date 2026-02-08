class_name GamePausedController extends CanvasLayer

@onready var in_game_ui_controller: InGameUIController = $"../InGameUIController"
@onready var continue_game_btn: Button = $Control/VBoxContainer/VBoxContainer/Continue
@onready var main_menu_btn: Button = $Control/VBoxContainer/VBoxContainer/MainMenu
@onready var fullscreen_checkbox: CheckBox = $Control/VBoxContainer/VBoxContainer/Body/Fields/Fullscreen
@onready var music_slider: Slider = $Control/VBoxContainer/VBoxContainer/Body/Fields/MusicVolume
@onready var sfx_slider: Slider = $Control/VBoxContainer/VBoxContainer/Body/Fields/SfxVolume

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
	
	continue_game_btn.button_up.connect(func():
		GlobalSound.singleton.play("UiPlop")
		in_game_ui_controller.is_paused = false
	)
	UiUtils.connect_button_to_scene_load(main_menu_btn, load("res://src/main-menu/main_menu.tres"))
