class_name Countdown
extends Label


signal countdown_finished

var _seconds: int = 0


func begin_countdown(seconds: int):
	_seconds = seconds
	_tick()


func _tick():
	if _seconds == 0:
		$StartStreamPlayer2D.play()
		set_text("START")
	else:
		$CountdownStreamPlayer2D.play()
		set_text("%d" % _seconds)
	
	$Timer.start(1)


func _on_timer_timeout():
	_seconds -= 1
	if _seconds < 0:
		$Timer.stop()
		countdown_finished.emit()
	else:
		_tick()
