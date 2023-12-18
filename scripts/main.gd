class_name GameInstance
extends Node2D

enum GameMode {
	## 1 player mode
	PLAYER_VS_CPU,
	## 2 players mode
	PLAYER_VS_PLAYER,
}

#@export var first_scene: PackedScene

var game_mode: GameMode = GameMode.PLAYER_VS_CPU

@onready var first_scene = preload("res://scene/main_menu.tscn").instantiate()


func _enter_tree():
	get_tree().process_frame.connect(
		func ():
			get_tree().root.add_child.call_deferred(first_scene),
		CONNECT_ONE_SHOT
	)
	


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
