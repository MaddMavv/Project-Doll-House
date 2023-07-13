#most of this is from the player movement script default they have. The animation stuff is me following the Tutorial -Neo
extends CharacterBody2D

var health = 5
const SPEED = 300.0
const JUMP_VELOCITY = -300.0

var doubleJump = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#onready means it runs when the scene starts
@onready var anim = get_node("AnimationPlayer")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("Jump")
	if Input.is_action_just_pressed("ui_accept") and not is_on_floor() and doubleJump == false:
		velocity.y = JUMP_VELOCITY
		doubleJump = true
		anim.play("Jump")
	if doubleJump == true and is_on_floor():
		doubleJump = false
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction == -1:
			get_node("AnimatedSprite2D").flip_h = true
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = false
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)		
		if velocity.y == 0:
			anim.play("Idle")
	if velocity.y > 0:
			anim.play("Fall")
			
#aparently this is the thing that makes the whole movement thing work
	move_and_slide()
