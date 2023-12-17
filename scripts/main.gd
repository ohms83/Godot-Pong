extends Node2D

enum GameState {
	NONE,
	BEGIN,
	COUNTDOWN,
	PLAY,
}

## Ball's starting speed
@export var ball_speed = 800

var _ball_start_pos: Vector2 = Vector2(960, 544)
var _player_scores: Array[int] = [0, 0]
var _state: GameState = GameState.NONE
var _state_process: Callable = Callable()
var _ball_direction: int = -1

@onready var _paddle1 = $Paddle_1
@onready var _paddle2 = $Paddle_2
@onready var _ball: Ball = $Ball
@onready var _player_controller: PlayerController = $PlayerController
@onready var _ai_controller: AI = $AI
@onready var _countdown: Countdown = $Countdown


# Called when the node enters the scene tree for the first time.
func _ready():
	_player_controller.target = _paddle1
	_ai_controller.target = _paddle2
	_ball.bounced_off.connect(_ai_controller.on_ball_bounced.bind())
	_countdown.countdown_finished.connect(_on_countdown_finished.bind())
	restart_game(-1)


func _process(_delta):
	if _state_process:
		_state_process.call()


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if event.is_action_pressed("game_reset"):
		restart_game(-1)


func _on_left_out_field_body_entered(body):
	if body.name == "Ball":
		await update_score(1)
		restart_game(1)


func _on_right_out_field_body_entered(body):
	if body.name == "Ball":
		await update_score(0)
		restart_game(-1)


func update_score(player_index: int):
	_player_scores[player_index] += 1
	await $Scoreboard.update_score(player_index, _player_scores[player_index])


func restart_game(ball_dir: int):
	_ball_direction = ball_dir
	_ball.visible = false
	_ball.position = _ball_start_pos
	_ball.velocity = Vector2.ZERO
	_ball.speed = ball_speed
	_state_process = _process_begin.bind()
	_state = GameState.BEGIN


func _process_begin():
	_countdown.visible = true
	_countdown.begin_countdown(3)
	_state = GameState.COUNTDOWN
	_state_process = Callable()

func _on_countdown_finished():
	_countdown.visible = false
	_ball.visible = true
	_ball.begin_move(_ball_direction)
	
	_ai_controller.on_ball_bounced(
		_ball.position,
		_ball.velocity.normalized()
	)
	
	_state = GameState.PLAY
