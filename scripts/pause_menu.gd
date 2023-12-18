extends Node2D

@export var highlight: Color
@export var normal_text: Color

var _button_index = 0
var _changing_scene = false

@onready var _main_menu_scene = preload("res://scene/main_menu.tscn").instantiate()
@onready var _menu_labels = [
	$Background/VBoxContainer/ResumeLabel,
	$Background/VBoxContainer/MainMenuLabel,
]

@onready var _max_btn_index = _menu_labels.size() - 1

@onready var button_delegates = [
	_resume_game.bind(),
	_to_main_menu.bind(),
]


func _ready():
	print("_ready()")
	

func _enter_tree():
	get_tree().paused = true
	get_tree().process_frame.connect(
		_set_label_color.bind(0, highlight),
		CONNECT_ONE_SHOT
	)
	print("_enter_tree()")


func _unhandled_input(event):
	if _changing_scene:
		return
	
	if event.is_action_pressed("ui_accept"):
		button_delegates[_button_index].call()
	elif event.is_action_pressed("ui_up"):
		if _button_index == 0:
			_button_index = _max_btn_index
		else:
			_button_index -= 1
		_select_option(_button_index)
	elif event.is_action_pressed("ui_down"):
		if _button_index == _max_btn_index:
			_button_index = 0
		else:
			_button_index += 1
		_select_option(_button_index)


func _set_label_color(index: int, color: Color):
	_menu_labels[index].label_settings.set_font_color(color)


func _select_option(index: int):
	if _changing_scene:
		return
	
	var game_modes = [
		GameInstance.GameMode.PLAYER_VS_CPU,
		GameInstance.GameMode.PLAYER_VS_PLAYER
	]
	for i in range(_menu_labels.size()):
		if i == index:
			_set_label_color(i, highlight)
		else:
			_set_label_color(i, normal_text)
	
	_button_index = index
	$MenuSelectStreamPlayer2D.play()


func _resume_game():
	if _changing_scene:
		return
	
	$StartGameStreamPlayer2D.play()
	
	var timer = Timer.new()
	$".".add_child(timer)
	timer.start(0.5)
	_changing_scene = true
	await timer.timeout
	
	# Change scene
	_changing_scene = false
	get_tree().paused = false
	get_parent().remove_child(self)


func _to_main_menu():
	if _changing_scene:
		return
	
	$StartGameStreamPlayer2D.play()
	
	var timer = Timer.new()
	$".".add_child(timer)
	timer.start(0.5)
	_changing_scene = true
	await timer.timeout
	
	# Change scene
	_changing_scene = false
	get_tree().root.add_child(_main_menu_scene)
	get_tree().root.remove_child(get_tree().root.get_node("Gameplay"))
	get_tree().paused = false
	$".".free()


func _on_resume_label_mouse_entered():
	_select_option(0)


func _on_main_menu_label_mouse_entered():
	_select_option(1)


func _on_resume_label_gui_input(event: InputEvent):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		_select_option(0)
		_resume_game()


func _on_main_menu_label_gui_input(event: InputEvent):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		_select_option(1)
		_to_main_menu()
