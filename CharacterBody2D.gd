extends CharacterBody2D


var cop = preload("res://melee cop.tscn")
var shmovin = false
var player
var done = false;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shmovin == true:
		position.x += 10;
		player = get_node("../BarB")
		if player.position.x <= (self.position.x-1300):
			player.position.x+=10;
		
	velocity.y = 0
	global_position.y = -552
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
		
func spawnDude():
	if shmovin == true:
		var copTemp = cop.instantiate()
		add_child(copTemp)
		player = get_node("../BarB")
		var dunkedOn = randi_range(1,4)
		if player.global_position.x < self.global_position.x:
			if dunkedOn > 1:
				copTemp.global_position = Vector2(1300, -1300) + self.position
			else:
				copTemp.global_position = Vector2(-1300, -1300) + self.position
		else:
			if dunkedOn > 1:
				copTemp.global_position = Vector2(-1300, -1300) + self.position
				
			else:
				copTemp.global_position = Vector2(1300, -1300) + self.position

func _on_spawn_timeout():
	spawnDude()
