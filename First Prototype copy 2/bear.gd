extends CharacterBody2D


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var projectile
var chase = false
var speed = 400
var knockback
var stun = false
@onready var timer = get_node("Timer")

#animation stuff
func _ready():
	pass
	#get_node("AnimatedSprite2D").play("Idle")

func _physics_process(delta):
	#frog gavity
	velocity.y += gravity * delta
	#makes it move towards the player
	
	if chase == true && stun == false:
		
		#if get_node("AnimatedSprite2D").animation != "Death":
		#	get_node("AnimatedSprite2D").play("Jump")
		player = get_node("../BarB")
		var direction = (player.position - self.position).normalized()
		if direction.x > 0:
		#	get_node("AnimatedSprite2D").flip_h = true
			if velocity.x < direction.x * speed:
				velocity.x += direction.x * speed
		else:
		#	get_node("AnimatedSprite2D").flip_h = false
			if velocity.x > direction.x * speed:
				velocity.x += direction.x * speed
		
	else:
		if velocity.x > 0:
			velocity.x -= 50
			if velocity.x < 0:
				velocity.x = 0;
		if velocity.x < 0:
			velocity.x += 50
			if velocity.x > 0:
				velocity.x = 0;
		#if get_node("AnimatedSprite2D").animation != "Death" && get_node("AnimatedSprite2D").animation != "Stunned":
		#	get_node("AnimatedSprite2D").play("Idle")
	move_and_slide()

#this checks if the player has entered the decetion area and sets it to chase. I think detection areas is the main way we'll do things with enemies
func _on_player_detection_body_entered(body):
	if body.name == "BarB" && stun == false:
		chase = true




#turns off chase when the player leaves the detection area
func _on_player_detection_body_exited(body):
	if body.name == "BarB":
		chase = false

		
func death():
	chase = false
	#get_node("AnimatedSprite2D").play("Death")
	#$DeathScream.play()
	#await get_node("AnimatedSprite2D").animation_finished
	#literally just deletes it
	self.queue_free()

func isHitLeft():
		print("left");
		velocity.x += 5000;
		velocity.y += -300;
	
func isHitRight():
		print("right");
		velocity.x -= 5000;
		velocity.y += -300;
	
func stunned():
	print("stunned")
	stun = true;
	velocity = Vector2(0,0);
	#get_node("AnimatedSprite2D").play("Stunned")
	$Timer.start()
	

func _on_player_death_area_entered(area):
	if area.name == "projectile":
		#projectile = get_node("../../projectile")
		#var direction = (projectile.position - self.position).normalized()
		print("help")
		velocity.x = 800


func _on_timer_timeout():
	stun = false;
	#if get_node("AnimatedSprite2D").animation != "Death":
	#k	get_node("AnimatedSprite2D").play("Idle")


func _on_player_punch_body_entered(body):
	if body.name == "BarB" && stun == false:
		Game.playerHP -= 1
