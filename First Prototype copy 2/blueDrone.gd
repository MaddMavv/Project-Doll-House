extends CharacterBody2D

@onready var bullet_scene = preload("res://bullet.tscn")
@onready var spawn_point: Marker2D = $SpawnPoint
@onready var timer = get_node("Timer")

# This variable stores a reference to the Player using Godot's Groups feature.
# Check the Player node in the inspector, switch to Node, and you'll see the group
# "Player" I created to make that happen.
@onready var player = get_tree().get_first_node_in_group("BarB")
var barb

var left = 210
var right = 200
var start
var chase = false
var stunned = false
var home = true
#for when stunned
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var fall = Vector2(0, 200)


func _ready():
	velocity = Vector2(150, 0)
	start = get_global_position()
	
	
func _process(delta):
	move(delta)
	shoot_at_player()
	stun()
	
	
func move(delta):
	
	if stunned == false and home == true:
		#moves up and down
		position += velocity * delta
		if position.x > start.x + right or position.x < start.x - left:
			velocity.x *= -1
			
	if stunned == true:
		home = false
		#falls to the ground
		move_and_collide(fall * delta)

	elif stunned == false and home == false:
		position.y -= 225 * delta
	
	if stunned == false and position.y < start.y:
		home = true
	
	
func shoot_at_player():
	#shoot function (below) calls bullet using this node
	if chase == true:
		barb = get_node("../BarB")
	
	
func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.position = spawn_point.global_position
	bullet.direction = global_position.direction_to(barb.position)
	owner.add_child(bullet)


func _on_timer_timeout():
		shoot() 
	
	
func stun():
	#press TAB to stun drone
	####will be replaced with actual stun####
	if chase == true and Input.is_action_just_pressed("ui_focus_next"):
		stunned = true
		$StunTimer.start()
		$Timer.stop()
	
		
func _on_player_detection_body_entered(body):
	if body.name == "BarB":
		if stunned == false:
			chase = true
			$Timer.start()
			

func _on_player_detection_body_exited(body):
	if body.name == "BarB":
		chase = false
		$Timer.stop()


func _on_stun_timer_timeout():
	stunned = false
	if chase == true:
		$Timer.start()
