extends Node2D

var vis := true


func _on_timer_timeout():
	if vis == true:
		self.visible = false
		vis = false
	else:
		self.visible = true
		vis = true


func _on_timer_2_timeout():
	queue_free()
