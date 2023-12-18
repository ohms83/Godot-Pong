extends Node2D

@export var highlight: Color
@export var normal_text: Color

var _button_index = 0
var _selected_game_mode: GameInstance.GameMode = GameInstance.GameMode.PLAYER_VS_CPU
var _changing_scene = false

@onready var _gameplay_scene = preload("res://scene/gameplay.tscn").instantiate()
@onready var _menu_labels = [
	$"Background/VBoxContainer/1PlayerLabel",
	$"Background/VBoxContainer/2PlayersLabel",
]

@onready var _max_btn_index = _menu_labels.size() - 1


func _ready():
	_menu_labels[0].label_settings.set_font_color(highlight)


func _unhandled_input(event):
	if _changing_scene:
		return
	
	if event.is_action_pressed("ui_accept"):
		_start_game()
	elif event.is_action_pressed("ui_up"):
		if _button_index == 0:
			_button_index = _max_btn_index
		else:
			_button_index -= 1
		_select_mode(_button_index)
	elif event.is_action_pressed("ui_down"):
		if _button_index == _max_btn_index:
			_button_index = 0
		else:
			_button_index += 1
		_select_mode(_button_index)


func _select_mode(index: int):
	if _changing_scene:
		return
	
	var game_modes = [
		GameInstance.GameMode.PLAYER_VS_CPU,
		GameInstance.GameMode.PLAYER_VS_PLAYER
	]
	for i in range(_menu_labels.size()):
		if i == index:
			_menu_labels[i].label_settings.set_font_color(highlight)
		else:
			_menu_labels[i].label_settings.set_font_color(normal_text)
	
	_button_index = index
	_selected_game_mode = game_modes[index]
	$MenuSelectStreamPlayer2D.play()


func _start_game():
	if _changing_scene:
		return
	
	var game_instance: GameInstance = get_tree().root.get_node("Main")
	game_instance.game_mode = _selected_game_mode
	$StartGameStreamPlayer2D.play()
	
	var timer = Timer.new()
	$".".add_child(timer)
	timer.start(0.5)
	_changing_scene = true
	await timer.timeout
	
	# Change scene
	get_tree().root.add_child(_gameplay_scene)
	$".".queue_free()

func _on_player_label_mouse_entered():
	_select_mode(0)


func _on_players_label_mouse_entered():
	_select_mode(1)


func _on_player_label_gui_input(event: InputEvent):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		_select_mode(0)
		_start_game()


func _on_players_label_gui_input(event):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		_select_mode(1)
		_start_game()
