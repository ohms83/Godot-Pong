extends Sprite2D

## Stretch the background sprite to fill the entire viewport
func _fill_viewport():
	var viewport_size = get_viewport().size
	var sprite_size = get_rect().size
	var scale = Vector2(viewport_size.x / sprite_size.x, viewport_size.y / sprite_size.y)
	apply_scale(scale)


# Called when the node enters the scene tree for the first time.
func _ready():
	_fill_viewport()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
