class_name SettingsMenuController extends Node

@onready var fullscreen_checkbox: CheckBox = $"../UI/VBoxContainer/Body/Fields/Fullscreen"
@onready var music_slider: Slider = $"../UI/VBoxContainer/Body/Fields/MusicVolume"
@onready var sfx_slider: Slider = $"../UI/VBoxContainer/Body/Fields/SfxVolume"
@onready var ui_slider: Slider = $"../UI/VBoxContainer/Body/Fields/UIScale"
@onready var reset_settings_button: Button = $"../UI/VBoxContainer/ResetSettingsButton"
@onready var main_menu_btn: Button = $"../UI/VBoxContainer/Button"
@onready var ui_scale_change_dialog = $"../UI/UI_Scale_Change_Dialog"
@onready var timer: Timer = $"../UI/UI_Scale_Change_Dialog/Timer"

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
			_show_confirmation_dialog()
	)
	
	reset_settings_button.button_up.connect(func():
		GlobalSound.singleton.play("UiPlop")
		SettingsManager.reset_settings()
		reset_ui()
	)
	
	ui_scale_change_dialog.get_ok_button().button_up.connect(_dialog_confirm)
	ui_scale_change_dialog.get_cancel_button().button_up.connect(_dialog_cancel)
	ui_scale_change_dialog.close_requested.connect(_dialog_cancel)
	timer.timeout.connect(func():
		_dialog_cancel()
		ui_scale_change_dialog.hide()
	)
	
	UiUtils.connect_button_to_scene_load(main_menu_btn, load("res://src/main-menu/main_menu.tres"))

func reset_ui() -> void:
	fullscreen_checkbox.button_pressed = SettingsManager.fullscreen
	music_slider.value = SettingsManager.music_volume
	sfx_slider.value = SettingsManager.sfx_volume
	ui_slider.value = SettingsManager.ui_scale

func _show_confirmation_dialog() -> void:
	ui_scale_change_dialog.popup_centered()
	timer.start()

func _dialog_confirm() -> void:
	GlobalSound.singleton.play("UiPlop")
	SettingsManager.save_UI_scale()
	timer.stop()

func _dialog_cancel() -> void:
	GlobalSound.singleton.play("UiPlop")
	SettingsManager.reset_UI_scale() # TODO should we reset to the default value or just keep the previous value? If keeping the previous value, just comment out this line.
	reset_ui()
	timer.stop()
