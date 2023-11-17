extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var extra_jumps=2
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = $AnimationPlayer

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		extra_jumps=2

	# Handle Jump.
	if (Input.is_action_just_pressed("ui_accept")or Input.is_action_just_pressed("ui_up")) and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("jump")
	elif Input.is_action_just_pressed("ui_accept") and extra_jumps > 0:
		velocity.y = JUMP_VELOCITY
		anim.play("jump")
		extra_jumps -= 1
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction == -1:
		$AnimatedSprite2D.flip_h = true
	elif direction == 1:
		$AnimatedSprite2D.flip_h = false
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("run")
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			anim.play("idle")
	if velocity.y > 0:
		anim.play("fall")
	move_and_slide()
