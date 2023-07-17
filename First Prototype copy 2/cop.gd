extends CharacterBody2D

var SPEED = 100
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var chase = false
var shoot = false
var run = false

func _ready():
	get_node("AnimatedSprite2D").play("Idle")

func _physics_process(delta):
	velocity.y += gravity * delta
	attack_player()
	run_from_player()
	move_and_slide()
	
	
func attack_player():	
	if chase == true:
		get_node("AnimatedSprite2D").play("Jump")
		player = get_node("../../BarB")
		var direction = (player.position - self.position).normalized()
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = true
		else:
			get_node("AnimatedSprite2D").flip_h = false
		velocity.x = direction.x * SPEED
	else:
		get_node("AnimatedSprite2D").play("Idle")
		velocity.x = 0
		
func run_from_player():
	if run == true:
		get_node("AnimatedSprite2D").play("Jump")
		player = get_node("../../BarB")
		var direction = (player.position + self.position).normalized()
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = false
		else:
			get_node("AnimatedSprite2D").flip_h = true
		velocity.x = direction.x * SPEED
	else:
		get_node("AnimatedSprite2D").play("Idle")

func _on_player_detection_body_entered(body):
	if body.name == "BarB":
		chase = true
		shoot = true

func _on_player_detection_body_exited(body):
	if body.name == "BarB":
		chase = false
		shoot = false

func _on_stop_body_entered(body):
	if body.name == "BarB":
		chase = false
		
func _on_stop_body_exited(body):
	if body.name == "BarB":
		chase = true 

func _on_run_away_body_entered(body):
	if body.name == "BarB":
		run = true

func _on_run_away_body_exited(body):
	if body.name == "BarB":
		run = false
