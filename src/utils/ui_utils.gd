# global script, imported in Projects/Project Settings/Globals

class_name UIUtils extends Node

func connect_button_to_scene_load(button: Button, module_to_load: ModuleInfo) -> void:
	button.button_up.connect(func(): ModulManager.singleton.load_module(module_to_load.id))
