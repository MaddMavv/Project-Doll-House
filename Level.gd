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
var mono = false;

func _ready():
# This is a total hack. FIX THIS
	Game.playerHP = 4
	Game.dead = false
	
	player = get_node("../Level 2/BarB")
	#Engine.max_fps = 60

func attack():
		var knockTemp = knock.instantiate()
		add_child(knockTemp)
		knockTemp.global_position = player.position
func stunAttack():
		var stunTemp = stun.instantiate()
		add_child(stunTemp)
		stunTemp.global_position = player.position
		
func _physics_process(delta):
		
	if Game.dead == true:
		player.anim.play("Death")
		await player.anim.animation_finished
#		Game.dead = false
		get_tree().change_scene_to_file("res://game_over.tscn")
	
	if Input.is_action_just_pressed("attack"):
		if player.meleeing == false:
			pain = true
	if pain == true:
		howLong +=1
		print(howLong)
		if howLong < 30:
			player.anim.play("Charging")
		else:
			player.anim.play("Charged")
		player.meleeing = true
	if Input.is_action_just_released("attack"):
		player.meleeing = false;
		if howLong < 30:
			pass
			#attack();
		if howLong >= 30:
			print("cool ig")
			stunAttack();
		pain = false;
		howLong = 0
		

func _on_train_moment_timeout():
	var trainTemp = train.instantiate()
	add_child(trainTemp)
	if whichTrain == 1:
		trainTemp.position = Vector2(player.position.x+6000, -1000)
	if whichTrain == 2:
		trainTemp.position = Vector2(player.position.x+6000, -200)
	if whichTrain == 3:
		trainTemp.position = Vector2(player.position.x+6000, 680)
	
	if here == true:
		$Warning.start()

func _on_warning_timeout():
	var warnTemp = warn.instantiate()
	add_child(warnTemp)
	
	if player.position.y < -650 && mono == false:
		warnTemp.position = Vector2(player.position.x, -1000)
		whichTrain = 1
	elif player.position.y < 250 && mono == false:
		warnTemp.position = Vector2(player.position.x, -200)
		whichTrain = 2
	else:
		warnTemp.position = Vector2(player.position.x, 650)
		whichTrain = 3
		
	$TrainMoment.start()


func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.name == "BarB":
		here = true
		mono = true
		$Warning.start()


func _on_area_2d_body_exited(body):
	if body.name == "BarB":
		here = false;
		mono = false;
		$TrainMoment.stop()
		$Warning.stop()


func _on_kill_box_body_entered(body):
	if body.name == "BarB":
		Game.playerHP = 0


func _on_area_2d_body_entered(body):
	if body.name == "BarB":
		get_tree().change_scene_to_file("res://thanks_for_playing.tscn")
