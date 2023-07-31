extends CharacterBody2D


const SPEED = 900.0
const JUMP_VELOCITY = -1000.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var flip = false
var meleeing = false
@export var maxjumpCount = 2
var jumpCount = maxjumpCount

@onready var anim = get_node("AnimationPlayer")

var veloReal = 0;
var veloOw = 0;

var veloRealY = 0;
var veloOwY = 0;


func _physics_process(delta):
	# Add the gravity.
	if is_on_floor():
		jumpCount = 0
		veloRealY = 0
	if not is_on_floor():
		veloRealY += gravity * delta
	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		veloRealY = JUMP_VELOCITY
		jumpCount = maxjumpCount
	# Handle Double jump.
	if jumpCount > 0 and Input.is_action_just_pressed("jump"):
		veloRealY = JUMP_VELOCITY
		jumpCount -= 1
		#anim.play("Jump")
		$jumpsound.play()
	# Handles drop through platform.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		if Input.is_action_pressed("move down"):
			set_collision_mask_value(2, false)
			veloRealY = JUMP_VELOCITY * -1
		#anim.play("Jump")
	# Handles double jump after drop through.
	if Input.is_action_just_pressed("jump") and not is_on_floor():
		if Input.is_action_just_released("move down"):
			veloRealY = JUMP_VELOCITY
			jumpCount = -1
	var direction = Input.get_axis("move left", "move right")
	if direction < 0:
			self.rotation_degrees = 180
			self.scale.y = -1.4
			flip = true
	elif direction > 0:
			self.rotation_degrees = 0;
			self.scale.y = 1.4
			flip = false
	
	velocity.x = veloReal+veloOw
	velocity.y = veloRealY+veloOwY
	
	veloOw = move_toward(veloOw, 0, 50)
	veloOwY = move_toward(veloOwY, 0, 50)
	
	if direction:
		veloReal = direction * SPEED
		if veloRealY == 0:
			if meleeing == false:
				anim.play("Run")
	else:
		veloReal = move_toward(veloReal, 0, SPEED)
		if veloRealY == 0:
			if meleeing == false:
				anim.play("Idle")
	if veloRealY > 0:
			if meleeing == false:
				pass
				#anim.play("Fall")
	if Input.is_action_just_pressed("melee"):
		melee()
		
	if Input.is_action_just_pressed("shout"):
		shout()
	
	move_and_slide()
	
func melee():
	if meleeing == false:
		anim.play("Melee")
		meleeing = true
		await anim.animation_finished
		meleeing = false;
		
func shout():
	if meleeing == false:
		anim.play("Shout")
		meleeing = true
		await anim.animation_finished
		meleeing = false;
		
func TRAIN():
	Game.playerHP -= 1;
	veloOw = -3000;
	veloOwY = -1500;
	set_collision_mask_value(4, false)
	

func _on_area_2d_body_entered(body):
	if body.is_in_group("Enemies"):
		body.death();
		
func _on_area_2d_2_body_entered(body):
	if body.is_in_group("Enemies"):
		body.chase = true


func _on_area_2d_3_body_exited(body):
	set_collision_mask_value(2, true)
