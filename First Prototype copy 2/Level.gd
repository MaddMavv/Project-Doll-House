extends Node2D


var knock = preload("res://knockback_projectile.tscn")
var stun = preload("res://stun_projectile.tscn")
var train = preload("res://train.tscn")
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
		howLong = 0;
	trainWait += 1;
	if trainWait == 100:
		whichTrain = randi_range(1,3)
		var trainTemp = train.instantiate()
		add_child(trainTemp)
		if whichTrain == 1:
			trainTemp.position = Vector2(6807, -244)
		if whichTrain == 2:
			trainTemp.position = Vector2(6807, 325)
		if whichTrain == 3:
			trainTemp.position = Vector2(6807, 894)
		trainWait = 0
