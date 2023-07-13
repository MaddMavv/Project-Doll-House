extends Node2D


var knock = preload("res://knockback_projectile.tscn")
var stun = preload("res://stun_projectile.tscn")
var player
var pain = false
var howLong = 0;

func attack():
		var knockTemp = knock.instantiate()
		add_child(knockTemp)
		player = get_node("../world/BarB")
		knockTemp.global_position = player.position
func stunAttack():
		var stunTemp = stun.instantiate()
		add_child(stunTemp)
		player = get_node("../world/BarB")
		stunTemp.global_position = player.position
		
func _physics_process(delta):
	if Input.is_action_just_pressed("attack"):
		pain = true;
	if pain == true:
		howLong +=1
		print(howLong)
	if Input.is_action_just_released("attack"):
		if howLong < 30:
			attack();
		if howLong >= 30:
			print("cool ig")
			stunAttack();
		pain = false;
		howLong = 0;
