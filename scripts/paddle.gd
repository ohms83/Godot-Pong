extends CharacterBody2D
class_name Paddle


@export var speed = 600
@onready var collider = $Collider


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	velocity.x = 0
	if not is_zero_approx(velocity.y):
		move_and_slide()

func move(direction: int):
	velocity.y = direction * speed
