class_name Controller
extends Node

var _move_dir: Vector2
var _mover: Mover


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _mover and not _move_dir.is_zero_approx():
		_mover.accelerate(_move_dir, delta)


func possess(target):
	_mover = target.get_node("Mover") as Mover
	assert(_mover)
