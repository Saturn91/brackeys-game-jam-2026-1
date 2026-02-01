# global script, imported in Projects/Project Settings/Globals

class_name EnvironmentUtils extends Node

var _set_web_debug: bool = false

enum Hosts {
	is_desktop_runtime,
	web_android,
	web_iosm,
	web_linuxbsd,
	web_macos,
	web_windows
}

func is_web() -> bool:
	if _set_web_debug:
		Debug.singleton.error("debug tool is set to always be web!")
		return true
	
	return OS.has_feature("web")
	
func get_web_os() -> Hosts:
	if OS.has_feature("web_windows"):
		return Hosts.web_windows
	if OS.has_feature("web_linuxbsd"):
		return Hosts.web_linuxbsd
	if OS.has_feature("web_macos"):
		return Hosts.web_macos
	if OS.has_feature("web_android"):
		return Hosts.web_android
	if OS.has_feature("web_iosm"):
		return Hosts.web_iosm
	return Hosts.is_desktop_runtime
	
func is_web_mobile() -> bool:
	return get_web_os() != Hosts.is_desktop_runtime
