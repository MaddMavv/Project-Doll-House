extends CharacterBody2D

@onready var bullet_scene = preload("res://bullet.tscn")
@onready var spawn_point: Marker2D = $SpawnPoint
@onready var timer = get_node("Timer")

# This variable stores a reference to the Player using Godot's Groups feature.
# Check the Player node in the inspector, switch to Node, and you'll see the group
# "Player" I created to make that happen.
@onready var player = get_tree().get_first_node_in_group("BarB")

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var barb

var top = 5
var bottom = 5
var left = 100
var right = 100
var start
var home = true
var chase = false
var stun = false
var fall = Vector2(0, 400)


func _ready():
	velocity = Vector2(.16, .07)
	start = get_global_position()
	
	
func _process(delta):
	chase_after_player(delta)

func chase_after_player(delta):
	if chase == true && stun == false:
		barb = get_node("../../../BarB")
		position.y = lerp(position.y, barb.position.y - 400, 1.4 * delta)
		position.x = lerp(position.x, barb.position.x + 375, .7 * delta)
		if position.x < barb.position.x:
			self.scale.x = -4;
		else:
			self.scale.x = 4
		home = false
		
	else:
		if home == false && stun == false:
			position = lerp(position, start, 1.4 * delta)
		
	if chase == false and position.x < start.x + 5 and position.x > start.x - 5 and position.y < start.y + 2 and position.y > start.y - 2:
		home = true
			
	if home == true && stun == false:
		position += velocity
		if position.y > start.y + bottom or position.y < start.y - top:
			velocity.y *= -1
		if position.x > start.x + right or position.x < start.x - left: 
			velocity.x *= -1
	if stun == true:
		home = false
		position = lerp(position, start, .4 * delta)
		#move_and_collide(fall * delta)

func barb_falls_off():
	pass

func _on_player_detection_body_entered(body):
	if body.name == "BarB":
		chase = true
		$Timer.start()


func _on_player_detection_body_exited(body):
	if body.name == "BarB":
		chase = false
		$Timer.stop()

func shoot():
	var bullet = bullet_scene.instantiate()
	if self.scale.x == 4:
		bullet.position = spawn_point.global_position + Vector2(-300, 0)
	else:
		bullet.position = spawn_point.global_position + Vector2(300, 0)
	bullet.direction = global_position.direction_to(barb.position)
	owner.add_child(bullet)

func _on_timer_timeout():
	if stun == false:
		shoot() 
	
func stunned():
	stun = true;
	velocity.x = 0;
	$stunTimer.start()
	$AnimatedSprite2D.play("Stunned")


func _on_stun_timer_timeout():
	stun = false;
	$AnimatedSprite2D.play("Flying")

func death():
	pass;

func _on_platform_detection_body_entered(body):
	if body.name == "BarB":
		body.TRAIN()
