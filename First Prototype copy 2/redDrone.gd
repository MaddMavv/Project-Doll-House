extends CharacterBody2D

@onready var bullet_scene = preload("res://bullet.tscn")
@onready var spawn_point: Marker2D = $SpawnPoint
@onready var timer = get_node("Timer")

# This variable stores a reference to the Player using Godot's Groups feature.
# Check the Player node in the inspector, switch to Node, and you'll see the group
# "Player" I created to make that happen.
@onready var player = get_tree().get_first_node_in_group("BarB")
var barb

var top = 250
var bottom = 150
var start
var chase = false
var stun = false
var home = true
var direction = -1
#for when stunned
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var on = false;


func _ready():
	velocity = Vector2(0, 200)
	start = get_global_position()
	barb = get_node("../../../BarB")
	
	
func _process(delta):
	move(delta)
	shoot_at_player()
	velocity.x = 0
	if stun == false:
		
		position.y += direction*1
		if on == true && direction == -1:
			barb.position.y += direction*1
		#moves up and down
		velocity.y = 0
	if stun == true:
		velocity.y += gravity*delta
	
	move_and_slide()
	
func move(delta):
	
	
		#position += velocity * delta
		#if position.y > start.y + bottom or position.y < start.y - top:
		#	velocity.y *= -1
			
	if stun == true:
		home = false
		#falls to the ground
		if velocity.y == -200:
			move_and_collide(velocity * -2 * delta)
		else:
			move_and_collide(velocity * 2 * delta)
	elif stun == false and home == false:
		pass#position.y -= 225 * delta
	
	#if stun == false and position.y < start.y + bottom:
	#	home = true
	
	
func shoot_at_player():
	#shoot function (below) calls bullet using this node
	if chase == true:
		barb = get_node("../../../BarB")
	
	
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
	if chase == true:
		stun = true
		$StunTimer.start()
		$Timer.stop()
	
		
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
		
		
func isHitLeft():
	pass;
func isHitRight():
	pass;


func _on_switch_direction_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.name == "up":
		direction = -1;
		
	if area.name == "down":
		direction = 1;
		


func _on_player_move_body_entered(body):
	if body.name == "BarB":
		on=true
		

func _on_player_move_body_exited(body):
	if body.name == "BarB":
		on=false
