class_name Scoreboard
extends Node2D


@onready var _score_labels = [$P1Score, $P2Score]


func update_score(player: int, score: int):
	_score_labels[player].set_text("%d" % score)
	$ScoreAudioStreamPlayer2D.play()
	
	$Timer.start(1)
	await $Timer.timeout
