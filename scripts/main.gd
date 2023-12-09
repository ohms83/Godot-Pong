extends Node2D

@onready var _paddle1 = $Paddle_1
@onready var _paddle2 = $Paddle_2
@onready var _player_controller: Controller = $PlayerController

# Called when the node enters the scene tree for the first time.
func _ready():
	_player_controller.possess(_paddle1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
