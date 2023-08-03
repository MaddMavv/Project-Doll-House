extends Control

var is_bottom_broken : bool = false
var is_left_broken : bool = false
var is_right_broken : bool = false
var heart_full  : bool = true


func _process(delta):
	#if Input.is_action_just_released("take_damage"):
		#Game.playerHP -= 1
	
	if  Game.playerHP == 3 and heart_full:
		$"Full to Broken".visible = false
		heart_full = false
		
	elif Game.playerHP == 2 and !is_right_broken:
		break_pieces($Rightside)
		is_right_broken = true
		
	elif Game.playerHP == 1 and !is_left_broken:
		break_pieces($Leftside)
		is_left_broken = true
		
	elif Game.playerHP <= 0 and !is_bottom_broken:
		break_pieces($BottomHeart)
		is_bottom_broken = true
		

		
func break_pieces(parts : Node):
	print("heart broken")
	for i in parts.get_children():
		i.freeze = false
		i.linear_velocity.x = randf_range(-1000, 1000)
		i.linear_velocity.x = randf_range(-1000, 1000)
		await get_tree().create_timer(0.05).timeout
		
