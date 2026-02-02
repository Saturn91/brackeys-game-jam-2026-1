class_name FPSCounter extends Label

var _original_text: String = "fps: #fps"

func _process(delta: float) -> void:
	text = _original_text.replace("#fps", str(Engine.get_frames_per_second()))
