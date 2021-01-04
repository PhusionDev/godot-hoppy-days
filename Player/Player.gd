extends KinematicBody2D

var motion = Vector2(0,0)
const SPEED = 500
const GRAVITY = 120
const UP = Vector2(0,-1)
const JUMP_FORCE = 2000

func _physics_process(delta):
	apply_gravity()
	move()
	animate()
	jump()
	motion = move_and_slide(motion, UP)

func apply_gravity():
	motion.y += GRAVITY
	
func jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		motion.y = -JUMP_FORCE

func move():
	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		motion.x = -SPEED
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		motion.x = SPEED
	else:
		motion.x = 0

func animate():
	if motion.y < 0:
		$AnimatedSprite.play("jump")
	elif not motion.x == 0:
		$AnimatedSprite.flip_h = motion.x < 0
		$AnimatedSprite.play("walk")
	else:
		$AnimatedSprite.play("idle")
