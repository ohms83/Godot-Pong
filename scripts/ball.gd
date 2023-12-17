class_name Ball
extends CharacterBody2D


## Send off when the ball is bounced off the wall or paddle.
signal bounced_off(from_pos: Vector2, direction: Vector2)


@export var speed = 800.0
## The speed modifier after each bounce
@export var speed_up = 50.0


func _physics_process(delta):
	var collision  = move_and_collide(velocity * delta)
	if collision:
		var normal = collision.get_normal()
		var name = collision .get_collider().name
		bounce(collision.get_normal())
		
		if name.to_lower().begins_with("paddle"):
			speed += speed_up
		
		print("Collide with %s normal=%s speed=%d" % [name, normal, speed])


## Begin moving to the specific direction where direction can be either -1 and 1
func begin_move(direction: int):
	velocity = Vector2(direction, randf_range(-0.5, 0.5)).normalized() * speed


func bounce(normal: Vector2):
	var reflect = (velocity.bounce(normal)).normalized()
	velocity = reflect * speed
	bounced_off.emit(position, reflect)
