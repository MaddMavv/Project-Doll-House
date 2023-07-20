extends Node2D


var knock = preload("res://knockback_projectile.tscn")
var stun = preload("res://stun_projectile.tscn")
var train = preload("res://train.tscn")
var warn = preload("res://warning.tscn")
var player
var pain = false
var howLong = 0;
var whichTrain
var trainWait = 0
var here = false;

func attack():
		var knockTemp = knock.instantiate()
		add_child(knockTemp)
		player = get_node("../Level 2/BarB")
		knockTemp.global_position = player.position
func stunAttack():
		var stunTemp = stun.instantiate()
		add_child(stunTemp)
		player = get_node("../Level 2/BarB")
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
		howLong = 0
		

func _on_train_moment_timeout():
	var trainTemp = train.instantiate()
	add_child(trainTemp)
	if whichTrain == 1:
		trainTemp.position = Vector2(26000, -1000)
	if whichTrain == 2:
		trainTemp.position = Vector2(26000, -200)
	if whichTrain == 3:
		trainTemp.position = Vector2(26000, 650)
	
	if here == true:
		$Warning.start()

func _on_warning_timeout():
	var warnTemp = warn.instantiate()
	add_child(warnTemp)
	player = get_node("../Level 2/BarB")
	
	if player.position.y < -650:
		warnTemp.position = Vector2(player.position.x, -1000)
		whichTrain = 1
	elif player.position.y < 250:
		warnTemp.position = Vector2(player.position.x, -200)
		whichTrain = 2
	else:
		warnTemp.position = Vector2(player.position.x, 650)
		whichTrain = 3
		
	$TrainMoment.start()
		
		


func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.name == "BarB":
		here = true
		$Warning.start()


func _on_area_2d_body_exited(body):
	if body.name == "BarB":
		here = false;
