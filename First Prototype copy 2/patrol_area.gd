extends Node2D

var home = true


func _on_area_2d_body_entered(body):
	if body.name == "DroneC":
		home = true
