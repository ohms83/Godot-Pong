class_name AI
extends Node

## AI's reaction time range in seconds
@export var react_time_range: Vector2 = Vector2(0.3, 1.2)
@export var stop_trshold = 10

@onready var reaction_timer = $ReactionTimer

var target: Paddle
var _move_target: float
var _is_moving: bool = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _is_moving:
		var target_y = _move_target - target.position.y
		if abs(target_y) < stop_trshold:
			_is_moving = false
			target.move(0)
		else:
			var dir = 1 if target_y > 0 else -1
			target.move(dir)


func on_ball_bounced(from_pos: Vector2, direction: Vector2):
	var to_target = target.position - from_pos
	if to_target.x * direction.x <= 0:
		# If the ball is moving to the opposite direction, do nothing.
		return
	
	_move_target = from_pos.y + ((direction.y * to_target.x) / direction.x)
	print("_move_target %d" % _move_target)
	
	var react_time = randf_range(react_time_range.x, react_time_range.y)
	reaction_timer.start(react_time)


## Connecting to ReactionTimer.timeout signal
func _on_begin_react():
	_is_moving = true
