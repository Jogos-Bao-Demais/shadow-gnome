extends CharacterBody2D

@export var _speed: float
@export var _friction: float
@export var _jump_velocity: float

@onready var _gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var _is_jumping: bool
var _dir: float

func _physics_process(delta: float) -> void:
	_handle_inputs()

	if not is_on_floor():
		velocity.y += _gravity * delta

	if _is_jumping and is_on_floor():
		velocity.y = _jump_velocity

	if _dir:
		velocity.x = _dir * _speed
	else:
		velocity.x = move_toward(velocity.x, 0, _friction)

	move_and_slide()

func _handle_inputs() -> void: 
	_is_jumping = Input.is_action_just_pressed("touch_jump")
	_dir = Input.get_axis("touch_left", "touch_right")


