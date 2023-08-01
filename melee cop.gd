extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("BarB")

var SPEED = 900
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var chase = true
var run = false
var stop = false
var runLeft = 600
var runRight = 600
var stun = false
var punch = false;
var punching = false

@onready var anim = get_node("AnimationPlayer")

func _ready():
	get_node("AnimatedSprite2D").play("Idle")
	player = get_node("../../BarB")


func _physics_process(delta):
	velocity.y += gravity * delta
	if stun == false:
		chase_after_player()
		if punch == true && anim.current_animation != "Punch":
			anim.play("Punch")
	move_and_slide()


func chase_after_player():
	if chase == true:
		get_node("AnimatedSprite2D").play("Run")
		var direction = (player.global_position - self.global_position).normalized()
		if direction.x > 0:
			self.rotation_degrees = 180
			self.scale.y = -1
		else:
			self.rotation_degrees = 0
			self.scale.y = 1
		velocity.x = direction.x * SPEED
	else:
		if stun == false:
			get_node("AnimatedSprite2D").play("Idle")
		velocity.x = 0

func stunned():
	stun = true;
	velocity.x = 0;
	velocity.y = 0;
	anim.play("Stunned")
	#get_node("AnimatedSprite2D").play("Stunned")
	$StunTimer.start()


func _on_stun_timer_timeout():
	stun = false;

func death():
	self.queue_free()


func _on_damage_body_entered(body):
	if body.name == "BarB":
		Game.playerHP -= 1;


func _on_punch_aoe_body_entered(body):
	if body.name == "BarB":
		punch = true;

func _on_punch_aoe_body_exited(body):
	if body.name == "BarB":
		punch = false;
