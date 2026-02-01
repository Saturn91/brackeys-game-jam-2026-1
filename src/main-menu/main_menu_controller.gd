class_name MainMenuControls extends Control

@onready var play_button: Button = $PlayButton
@onready var settings_button: Button = $SettingsButton
@onready var credits_button: Button = $CreditsButton
@onready var close_button: Button = $CloseButton

func _ready() -> void:
	connect_button_to_scene_load(play_button, load("res://src/game/game.tres"))
	connect_button_to_scene_load(settings_button, load("res://src/settings-menu/settings_menu.tres"))
	connect_button_to_scene_load(credits_button, load("res://src/credits/credits.tres"))
	if EnvUtils.is_web(): close_button.hide()

func connect_button_to_scene_load(button: Button, module_to_load: ModuleInfo) -> void:
	button.button_up.connect(func(): ModulManager.singleton.load_module(module_to_load.id))
