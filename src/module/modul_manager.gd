class_name ModulManager extends Node

@export var modules: Array[ModulInfo] = []

@onready var module_root = $ModuleRoot

var _module_mapping: Dictionary[String, ModulInfo]
var _current_module: Module
var _current_module_id: String

func _ready() -> void:
	_module_mapping = {}
	initialize_module_mapping()
	load_module("main-menu")
	
func initialize_module_mapping() -> void:
	for m in modules:
		_module_mapping.set(m.id, m)

func load_module(module_id: String) -> void:
	if !_module_mapping.has(module_id):
		Debug.singleton.warn("valid module-id's: " + str(_module_mapping.keys()))
		Debug.singleton.error("module [" + module_id + "] does not exist")
	else:
		unload_current_module()
		var new_module = (_module_mapping.get(module_id) as ModulInfo).scene.instantiate()
		module_root.add_child(new_module)
		_current_module_id = module_id

func unload_current_module() -> void:
	if _current_module:
		_current_module.unload()
