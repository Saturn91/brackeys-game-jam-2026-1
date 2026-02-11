# global script, imported in Projects/Project Settings/Globals
extends Node

const SETTINGS_PATH := "user://settings.cfg"

const default_fullscreen: bool = false
const default_music_volume: float = 1.0
const default_sfx_volume: float = 1.0
const default_ui_scale: float = 1.0

var fullscreen: bool = default_fullscreen:
	set = set_fullscreen
var music_volume: float = default_music_volume:
	set = set_music_volume
var sfx_volume: float = default_sfx_volume:
	set = set_sfx_volume
var ui_scale: float = default_ui_scale:
	set = set_ui_scale

func _ready() -> void:
	load_settings()
	apply_volumes()
	init_ui_scale()

func get_volume_db(volume: float) -> float:
	if volume <= 0.1:
		return -80.0
	else:
		return linear_to_db(volume * 0.5)

func apply_volumes() -> void:
	var music_bus = AudioServer.get_bus_index("Music")
	var sfx_bus = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(music_bus, get_volume_db(music_volume))
	AudioServer.set_bus_volume_db(sfx_bus, get_volume_db(sfx_volume))

func init_ui_scale() -> void:
	var window: Window = get_window()
	# CONTENT_SCALE_MODE_CANVAS_ITEMS is more performance-expensive, but much nicer looking
	# CONTENT_SCALE_MODE_VIEWPORT is less performance-expensive, but makes it look much more pixelated
	window.content_scale_mode = Window.CONTENT_SCALE_MODE_CANVAS_ITEMS
	apply_ui_scale()

func apply_ui_scale() -> void:
	var window: Window = get_window()
	window.content_scale_factor = ui_scale

func set_fullscreen(value: bool) -> void:
	fullscreen = value
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	save_settings()

func set_music_volume(value: float) -> void:
	music_volume = value
	apply_volumes()
	save_settings()

func set_sfx_volume(value: float) -> void:
	sfx_volume = value
	apply_volumes()
	save_settings()

func set_ui_scale(value: float) -> void:
	ui_scale = value
	apply_ui_scale()
	# save_settings() We don't save this directly, instead use a save button, to allow resetting 
	# when by restarting the game

## Saves all settings, including UI-scale.
##
## See [method save_settings].
func save_all_settings() -> void:
	_save_settings_to_file(true)

## Saves all settings except UI-scale, as setting a wrong UI-scale can possibly prevent
## changing it back.
## 
## Use [method save_all_settings] to save everything including UI-scale
func save_settings() -> void:
	_save_settings_to_file(false)
	
func _save_settings_to_file(with_ui: bool) -> void:
	var config := ConfigFile.new()

	config.set_value("video", "fullscreen", fullscreen)
	config.set_value("audio", "music_volume", music_volume)
	config.set_value("audio", "sfx_volume", sfx_volume)
	if with_ui:
		config.set_value("ui", "ui_scale", ui_scale)

	var err = config.save(SETTINGS_PATH)
	if err != OK:
		Debug.error("Failed to save settings")
	
func load_settings():
	var config := ConfigFile.new()
	var err = config.load(SETTINGS_PATH)

	if err != OK:
		save_all_settings()
		return

	fullscreen = config.get_value("video", "fullscreen", fullscreen)
	music_volume = config.get_value("audio", "music_volume", music_volume)
	sfx_volume = config.get_value("audio", "sfx_volume", sfx_volume)
	ui_scale = config.get_value("ui", "ui_scale", ui_scale)
	apply_volumes()

func reset_settings() -> void:
	fullscreen = default_fullscreen
	music_volume = default_music_volume
	sfx_volume = default_sfx_volume
	ui_scale = default_ui_scale
	apply_volumes()
	apply_ui_scale()
	save_all_settings()
