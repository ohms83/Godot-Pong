class_name Ball
extends CharacterBody2D


## Send off when the ball is bounced off the wall or paddle.
signal bounced_off(from_pos: Vector2, direction: Vector2)


@export var speed = 800.0
## The speed modifier after each bounce
@export var speed_up = 50.0


func _physics_process(delta):
	var collision: KinematicCollision2D  = move_and_collide(velocity * delta)
	if collision:
		var normal = collision.get_normal()
		var name = collision .get_collider().name
		var is_paddle = name.to_lower().begins_with("paddle")
		
		var vec_mod: Vector2 = Vector2.ZERO
		if is_paddle:
			var paddle: Paddle = collision.get_collider()
			vec_mod = paddle.velocity * 0.2
		
		bounce(collision.get_normal(), vec_mod)
		
		if is_paddle:
			speed += speed_up
		
		$AudioStreamPlayer2D.play()
		print("Collide with %s normal=%s speed=%d" % [name, normal, speed])


## Begin moving to the specific direction where direction can be either -1 and 1
func begin_move(direction: int):
	velocity = Vector2(direction, randf_range(-0.5, 0.5)).normalized() * speed
	print("begin_move direction=%d" % [direction])


func bounce(normal: Vector2, velocity_mod: Vector2 = Vector2.ZERO):
	var reflect = (velocity.bounce(normal)).normalized()
	velocity = reflect * speed
	velocity += velocity_mod
	bounced_off.emit(position, reflect)
	print("bounce normal=%s velocity_mod=%d" % [normal, velocity_mod])
