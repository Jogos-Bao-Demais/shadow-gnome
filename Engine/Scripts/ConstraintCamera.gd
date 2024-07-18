extends Camera2D

@export var _bottom_limit: float

func _process(_delta) -> void:
	global_position.y = clamp(global_position.y, limit_top, _bottom_limit)
