extends CharacterBody2D

@onready var bullet_scene = preload("res://bullet.tscn")
@onready var spawn_point: Marker2D = $SpawnPoint
@onready var timer = get_node("Timer")

# This variable stores a reference to the Player using Godot's Groups feature.
# Check the Player node in the inspector, switch to Node, and you'll see the group
# "Player" I created to make that happen.
@onready var player = get_tree().get_first_node_in_group("BarB")
var barb

#new code for drone movement
var targetX
@export var range = Vector2(500, 0)
@export var h_move = Vector2(0.00, 0.00)
@export var add = Vector2(0.01, 0.00)
#old movement code but leaving it in for now
#var left = 210
#var right = 200

var start
var chase = false
var stun = false
var home = true
#for when stunned
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var fall = Vector2(0, 400)


func _ready():
	#velocity = Vector2(150, 0)
	start = get_global_position()
	
	
func _process(delta):
	move(delta)
	shoot_at_player()
	
	
func move(delta):
	
	if stun == false and home == true:
		#moves up and down
		targetX = sin(h_move.x) * range.x * delta
		position.x += targetX
		h_move.x += add.x
		
		#old movement
		#position += velocity * delta
		#if position.x > start.x + right or position.x < start.x - left:
		#	velocity.x *= -1
			
	if stun == true:
		home = false
		#falls to the ground
		move_and_collide(fall * delta)
	elif home == false and position.y > start.y:
		position.y -= 225 * delta
	elif position.y < start.y:
		position.y = start.y
	
	if home == false and position.y == start.y and position.x > start.x:
		position.x -= 225 * delta
	
	if stun == false and home == false and position.y == start.y and position.x < start.x:
		position.x = start.x
		home = true 
		h_move = Vector2(0.00, 0.00)
	
	
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
	#press TAB to stun drone
	####will be replaced with actual stun####
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
	if chase == true:
		$Timer.start()
	$AnimatedSprite2D.play("Flying")
	
func death():
	pass;
