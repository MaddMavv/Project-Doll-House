extends CharacterBody2D

@export var bullet: PackedScene
@onready var spawn_point: Marker2D = $SpawnPoint

var start
var top = 5
var bottom = 5
var left = 100
var right = 50
var home = true

var chase = false
var player
# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2(.16, .07)
	start = get_global_position()
	print(start)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	chase_after_player(delta)
	
func chase_after_player(delta):
	if chase == true:
		player = get_node("../BarB")
		position.y = lerp(position.y, player.position.y - 400, 1.8 * delta)
		position.x = lerp(position.x, player.position.x + 175, 1.2 * delta)
		home = false
		
		if Input.is_action_just_pressed("ui_focus_next"):
			shoot()
	else:
		if home == false:
			position = lerp(position, start, .7 * delta)
		
	if chase == false and position.x < start.x + 5 and position.x > start.x - 5 and position.y < start.y + 2 and position.y > start.y - 2:
		home = true
			
	if home == true:
		position += velocity
		if position.y > start.y + bottom or position.y < start.y - top:
			velocity.y *= -1
		if position.x > start.x + right or position.x < start.x - left: 
			velocity.x *= -1
			
func _on_player_detection_body_entered(body):
	if body.name == "BarB":
		chase = true

func _on_player_detection_body_exited(body):
	if body.name == "BarB":
		chase = false

func _on_timer_timeout():
	pass
	
func shoot():
	var inst: Bullet = bullet.instantiate()
	owner.add_child(inst)
	inst.transform = spawn_point.global_transform
