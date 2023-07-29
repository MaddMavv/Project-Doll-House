extends Node2D


@onready var player = get_node("../Boss/BarB")

var waiting = 0

var knock = preload("res://knockback_projectile.tscn")
var stun = preload("res://stun_projectile.tscn")
var train = preload("res://train.tscn")
var warn = preload("res://warning.tscn")
var pain = false
var howLong = 0;
var whichTrain
var trainWait = 0
var here = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$bossCam.make_current()
	Game.boss = true;

func attack():
		var knockTemp = knock.instantiate()
		add_child(knockTemp)
#		player = get_node("../Boss/BarB")
		knockTemp.global_position = player.position
func stunAttack():
		var stunTemp = stun.instantiate()
		add_child(stunTemp)
#		player = get_node("../Boss/BarB")
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

	if Input.is_action_just_pressed("shout") && waiting <= 0:
		shout()
		waiting = 1
	if waiting > 0:
		waiting -= delta;

	print(waiting)


func shout():
	var warnTemp = warn.instantiate()
	add_child(warnTemp)
#	player = get_node("../Boss/BarB")

	print("test")
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

func _on_train_moment_timeout():
	var trainTemp = train.instantiate()
	add_child(trainTemp)
	trainTemp.scale.x = -1;
	if whichTrain == 1:
		trainTemp.position = Vector2(400, -1000)
	if whichTrain == 2:
		trainTemp.position = Vector2(400, -200)
	if whichTrain == 3:
		trainTemp.position = Vector2(400, 650)

