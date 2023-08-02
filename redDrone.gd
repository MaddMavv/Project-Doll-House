extends CharacterBody2D

@onready var bullet_scene = preload("res://bullet.tscn")
@onready var spawn_point: Marker2D = $SpawnPoint
@onready var timer = get_node("Timer")

# This variable stores a reference to the Player using Godot's Groups feature.
# Check the Player node in the inspector, switch to Node, and you'll see the group
# "Player" I created to make that happen.
@onready var player = get_tree().get_first_node_in_group("BarB")
@onready var barb : CharacterBody2D = get_node("../../../../BarB")


##NEW NEW movement
@export var acceleration = Vector2(0.00, 0.00)
@export var velo = Vector2(0, 5)
##this changes the drone distance 
@export var accNum = Vector2(0.00, 0.015)
@export var moveSpeed = 5
var fall = Vector2(0, 600)

#new drone movement
#var targetY
#@export var range = Vector2(0, 500)
#@export var v_move = Vector2(0.00, 0.00)
#@export var add = Vector2(0.00, 0.01)


#old script - track changes for now 
#var top = 250
#var bottom = 150

@onready var start
var chase = false
var stun = false
var home = true
var direction = -1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var on = false;


func _ready():
	#velocity = Vector2(0, 200)
	start = get_global_position()
	
	
func _process(delta):
	move(delta)
	shoot_at_player()
	
func move(delta):
		##out with the old 
		#targetY = sin(v_move.y) * range.y * delta
		#position.y += targetY
		#v_move.y += add.y
		#print(position.y)
			
	if stun == true:
		home = false
		#falls to the ground
		move_and_collide(fall * delta)
	elif stun == false and home == false:
		velo.y = -5
		position += velo
	else:
		#moves up and down
		position += velo
		velo += acceleration
		velo.y = clamp(velo.y, -moveSpeed, moveSpeed)
		
		if position.y > start.y:
			acceleration.y = -accNum.y
		
		if position.y < start.y:
			acceleration.y = accNum.y
	
	#resets motion after stun 
	if stun == false and home == false and position.y < start.y:
		home = true
	
	#more old code -- will get rid of it once I'm confident this fix works on other computers
	#elif home == false and position.y > start.y:
	#	position.y -= 225 * delta
	
	#if stun == false and position.y < start.y:
		#position.y = start.y
	#	home = true 
		#v_move = Vector2(0.00, 0.00)
	
func shoot_at_player():
	#shoot function (below) calls bullet using this node
	if chase == true:
		barb = get_node("../../../../BarB")
	
	
func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.position = spawn_point.global_position
	bullet.direction = global_position.direction_to(barb.position)
	owner.add_child(bullet)


func _on_timer_timeout():
		shoot() 
	
	
func stunned():
	if chase == true:
		stun = true
		$StunTimer.start()
		$Timer.stop()
		$AnimatedSprite2D.play("Stunned")
		
func _on_player_detection_body_entered(body):
	if body.name == "BarB":
		if stun == false:
			chase = true
			$Timer.start()
			

func _on_player_detection_body_exited(body):
	if body.name == "BarB":
		chase = false
		$Timer.stop()


func _on_stun_timer_timeout():
	stun = false
	$AnimatedSprite2D.play("Flying")
	if chase == true:
		$Timer.start()
		
		
func isHitLeft():
	pass;
func isHitRight():
	pass;


func _on_player_move_body_entered(body):
	if body.name == "BarB":
		on=true
		

func _on_player_move_body_exited(body):
	if body.name == "BarB":
		on=false

func death():
	pass;
