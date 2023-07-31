extends CharacterBody2D


var speed = 3600;
var player
var direction
var help = 0

func _ready():
	player = get_node("../BarB")
	if player.scale.y > 0:
		direction = Vector2.RIGHT.rotated(rotation)
	if player.scale.y < 0:
		direction = Vector2.LEFT.rotated(rotation)

func _physics_process(delta):
	global_position += speed*direction*delta


func _on_timer_timeout():
	queue_free()


func _on_area_2d_body_entered(body):
	if body.is_in_group("Enemies"):
		if direction == Vector2.RIGHT.rotated(rotation):
			body.isHitLeft();
		elif direction == Vector2.LEFT.rotated(rotation):
			body.isHitRight();
		
