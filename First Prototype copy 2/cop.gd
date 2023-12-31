extends CharacterBody2D

@onready var bullet_scene = preload("res://bullet.tscn")
@onready var timer = get_node("Timer")
@onready var spawn_point: Marker2D = $SpawnPoint
@onready var player = get_tree().get_first_node_in_group("BarB")

var SPEED = 250
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var chase = false
var run = false
var stop = false
var runLeft = 300
var runRight = 300

func _ready():
	get_node("AnimatedSprite2D").play("Idle")


func _physics_process(delta):
	velocity.y += gravity * delta
	chase_after_player()
	stop_and_attack()
	run_from_player(delta)
	move_and_slide()
	
	
func chase_after_player():	
	if chase == true:
		#get_node("AnimatedSprite2D").play("Jump")
		player = get_node("../BarB")
		var direction = (player.position - self.position).normalized()
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = true
		else:
			get_node("AnimatedSprite2D").flip_h = false
		velocity.x = direction.x * SPEED
	else:
		get_node("AnimatedSprite2D").play("Idle")
		velocity.x = 0
		
func stop_and_attack():
	if stop == true:
		get_node("AnimatedSprite2D").play("Idle")
		velocity.x = 0
		
func run_from_player(delta):
	if run == true:
		#get_node("AnimatedSprite2D").play("Jump")
		player = get_node("../BarB")
		if player.position.x < position.x:
			velocity.x += runRight * delta
		if player.position.x > position.x:
			velocity.x -= runLeft * delta
		position.x += velocity.x
		#if direction.x > 0:
		#	get_node("AnimatedSprite2D").flip_h = false
		#else:
		#	get_node("AnimatedSprite2D").flip_h = true
		#velocity.x = direction.x * SPEED
		

func _on_player_detection_body_entered(body):
	if body.name == "BarB":
		if stop == false:
			chase = true
		$Timer.start()

func _on_player_detection_body_exited(body):
	if body.name == "BarB":
		chase = false
		$Timer.stop()

func _on_stop_body_entered(body):
	if body.name == "BarB":
		if run == false:
			stop = true
		
func _on_stop_body_exited(body):
	if body.name == "BarB":
		stop = false
		
func _on_run_away_body_entered(body):
	if body.name == "BarB":
		run = true

func _on_run_away_body_exited(body):
	if body.name == "BarB":
		run = false
		
func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.position = spawn_point.global_position
	bullet.direction = global_position.direction_to(player.position)
	owner.add_child(bullet)

func _on_timer_timeout():
	shoot()
