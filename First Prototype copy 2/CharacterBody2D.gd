extends CharacterBody2D

@onready var player = get_node("../BarB")

var shmovin = false
var done = false


func _process(delta):
	if shmovin == true:
		position.x = position.x+1;
#		player = get_node("../BarB")
		if player.position.x <= (self.position.x-1300):
			player.position.x+=10;

	velocity.y = 0;
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.name == "BarB" && done == false:
		$Wall1.set_deferred("disabled", false)
		$Wall2.set_deferred("disabled", false)
		shmovin = true


func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.name == "DroneStop":
		done = true
		shmovin = false
		$Wall1.set_deferred("disabled", true)
		$Wall2.set_deferred("disabled", true)
