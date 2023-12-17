class_name Paddle
extends CharacterBody2D


@export var speed = 600


func _physics_process(delta):
	velocity.x = 0
	if not is_zero_approx(velocity.y):
		move_and_slide()

func move(direction: int):
	velocity.y = direction * speed
