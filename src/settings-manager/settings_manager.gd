class_name SettingsManager extends Node

static var singleton: SettingsManager

const SETTINGS_PATH := "user://settings.cfg"

var fullscreen: bool = false:
	set = set_fullscreen
var music_volume: float = 1.0:
	set = set_music_volume
var sfx_volume: float = 1.0:
	set = set_sfx_volume

func _ready() -> void:
	singleton = self
	load_settings()

func set_fullscreen(value: bool) -> void:
	fullscreen = value
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	save_settings()

func set_music_volume(value: float) -> void:
	music_volume = value
	save_settings()

func set_sfx_volume(value: float) -> void:
	sfx_volume = value
	save_settings()

func save_settings() -> void:
	var config := ConfigFile.new()

	config.set_value("video", "fullscreen", fullscreen)
	config.set_value("audio", "music_volume", music_volume)
	config.set_value("audio", "sfx_volume", sfx_volume)

	var err = config.save(SETTINGS_PATH)
	if err != OK:
		Debug.singleton.error("Failed to save settings")
	
func load_settings():
	var config := ConfigFile.new()
	var err = config.load(SETTINGS_PATH)

	if err != OK:
		save_settings()
		return

	fullscreen = config.get_value("video", "fullscreen", fullscreen)
	music_volume = config.get_value("audio", "music_volume", music_volume)
	sfx_volume = config.get_value("audio", "sfx_volume", sfx_volume)
