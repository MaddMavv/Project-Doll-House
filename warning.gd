extends Node2D

var vis = true;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_timer_timeout():
	if vis == true:
		self.visible = false
		vis = false
	else:
		self.visible = true
		vis = true


func _on_timer_2_timeout():
	queue_free()
