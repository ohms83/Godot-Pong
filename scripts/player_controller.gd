class_name PlayerController
extends Controller


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("paddle_up"):
		_move_dir = Vector2.UP
	elif Input.is_action_pressed("paddle_down"):
		_move_dir = Vector2.DOWN
	else:
		_move_dir = Vector2.ZERO
		
	super._process(delta)
