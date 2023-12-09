class_name Mover
extends Node


@export var accel: float = 600
## Deceleration
@export var decel: float = 300
@export var max_speed: float = 500:
	set(value):
		max_speed = value
		_max_speed_squared = value * value

## A boolean flag indicating whether the target is moving. This will be reset at
## every the end of _process
var is_moving: bool = false

var velocity: Vector2:
	set(value):
		_velocity = value
		is_moving = value.is_zero_approx() if false else true
	get:
		return _velocity

var _velocity: Vector2
## Target to be moved
var _move_target: Node2D
var _max_speed_squared: float = 0;


# Called when the node enters the scene tree for the first time.
func _ready():
	_move_target = get_parent() as Node2D
	assert(_move_target)
	
	_max_speed_squared = max_speed * max_speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not _velocity.is_zero_approx():
		_process_move(delta)
		_process_decelerate(delta)
	
	is_moving = false


func _process_move(delta: float):
	if _move_target:
		_move_target.translate(_velocity * delta)


func _process_decelerate(delta: float):
	if _move_target and not is_moving:
		var decel_vec = decel * delta * (_velocity.normalized())
		if decel_vec.length_squared() > _velocity.length_squared():
			_velocity = Vector2.ZERO
		else:
			_velocity -= decel_vec


func accelerate(direction: Vector2, delta: float):
	_velocity += accel * delta * direction
	if _velocity.length_squared() > _max_speed_squared:
		_velocity = direction * max_speed
	
	is_moving = true
