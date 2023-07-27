extends CharacterBody2D


var speed = 1800;
var player
var direction
var help = 0


func _physics_process(delta):
	scale += Vector2(0.6,0.6);


func _on_timer_timeout():
	queue_free()


func _on_area_2d_body_entered(body):
	if body.is_in_group("Enemies"):
		body.stunned();
		
