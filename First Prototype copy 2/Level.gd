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
		
		

func _on_train_moment_timeout():
	var trainTemp = train.instantiate()
	add_child(trainTemp)
	if whichTrain == 1:
		trainTemp.position = Vector2(6807, -244)
	if whichTrain == 2:
		trainTemp.position = Vector2(6807, 325)
	if whichTrain == 3:
		trainTemp.position = Vector2(6807, 894)
	
	$Warning.start()

func _on_warning_timeout():
	whichTrain = randi_range(1,3)
	var warnTemp = warn.instantiate()
	add_child(warnTemp)
	player = get_node("../world/BarB")
	
	if whichTrain == 1:
		warnTemp.position = Vector2(player.position.x, -254)
	elif whichTrain == 2:
		warnTemp.position = Vector2(player.position.x, 315)
	elif whichTrain == 3:
		warnTemp.position = Vector2(player.position.x, 884)
		
	$TrainMoment.start()
		
		
