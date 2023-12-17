class_name Countdown
extends Label


signal countdown_finished

var _timer: float = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _timer > 0:
		_timer -= delta
		if _timer <= 0:
			_timer = 0
			countdown_finished.emit()
	
	_update_label()


func begin_countdown(seconds: float):
	_timer = seconds
	_update_label()


func _update_label():
	var seconds: int = _timer
	set_text("%d" % seconds)
