extends CharacterBody2D

@onready var bullet_scene = preload("res://bullet.tscn")
@onready var spawn_point: Marker2D = $SpawnPoint

# This variable stores a reference to the Player using Godot's Groups feature.
# Check the Player node in the inspector, switch to Node, and you'll see the group
# "Player" I created to make that happen.
@onready var player = get_tree().get_first_node_in_group("Player")

var top = 500
var bottom = 555
var left = 450
var right = 540
var start
var home = true
var chase = false


func _ready():
	velocity = Vector2(.16, .07)
	start = get_global_position()
	

func _process(delta):
	chase_after_player(delta)


func chase_after_player(delta):
	if chase == true:
		position.y = lerp(position.y, player.position.y - 50, .9 * delta)
		position.x = lerp(position.x, player.position.x + 75, .6 * delta)
		home = false
		
		if Input.is_action_just_pressed("ui_focus_next"):
			shoot()
		
	else:
		if home == false:
			position = lerp(position, start, .7 * delta)
		
	if chase == false and position.x < start.x + 10 and position.x > start.x - 10 and position.y < start.y + 2 and position.y > start.y - 2:
		home = true
			
	if home == true:
		position += velocity
		if position.y > bottom or position.y < top:
			velocity.y *= -1
		if position.x > right or position.x < left: 
			velocity.x *= -1


func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true


func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false


func _on_timer_timeout():
	pass


func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.position = spawn_point.global_position
	bullet.direction = global_position.direction_to(player.position)
	owner.add_child(bullet)
