class_name PlayerController
extends Node


var target: Paddle


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	target.move(0)
	if Input.is_action_pressed("paddle_down"):
		target.move(1)
	elif Input.is_action_pressed("paddle_up"):
		target.move(-1)
