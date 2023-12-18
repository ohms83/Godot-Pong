class_name PlayerController
extends Node

@export var paddle_up_action: String = "paddle_down"
@export var paddle_down_action: String = "paddle_up"

var target: Paddle


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	target.move(0)
	if Input.is_action_pressed(paddle_up_action):
		target.move(1)
	elif Input.is_action_pressed(paddle_down_action):
		target.move(-1)
