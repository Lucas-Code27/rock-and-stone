extends Marker2D

var testen: PackedScene = preload("res://Enemy/TestEnemy.tscn")
var light: PackedScene = preload("res://Enemy/Footsoldier/footsoldier.tscn")
var medium: PackedScene = preload("res://Enemy/Medium/medium.tscn")
var heavy: PackedScene = preload("res://Enemy/Heavy/heavy.tscn")

@export var gamestate: Node2D
@export var hud:Control

var i:int = 0

var wave: int = 1
var enemiesperwave:int = 15
var spawntime: float = 1.4
var roundtime: float = 0
var spawncount: int = 1
var maxdelay: float = 0.18
var mindelay: float = 0.04

var maxst: float
var minst: float

var waverunning: bool = false
var enemiesalive: int = 0

var spawnsleft: int = 0

func _ready() -> void:
	spawnsleft = 0
	enemiesalive = 0
	$Timer.wait_time = spawntime
	$delay.wait_time = maxdelay
	
	$Timer.stop()
	$delay.stop()
	await gamestate.defending == false
	waverunning = false

func _on_timer_timeout() -> void:
	var wavediv: float = wave
	
	while i < spawncount:
		$delay.start()
		await $delay.timeout
		$delay.wait_time = randf_range(maxdelay,mindelay)
		call_deferred("spawn")
		i += 1
		roundtime += 0.1 + wavediv/10
		spawncount = 1 + round(roundtime)
	i = 0
	roundtime = 0
	spawntime *= 0.6
	
	if spawntime < 0.1:
		spawntime = 0.1
	maxst = spawntime
	minst = spawntime * 0.8
	if minst < 0.18:
		minst = 0.18
	
	if spawnsleft < 1:
		$Timer.stop()
		$delay.stop()
		await gamestate.defending == false
		waverunning = false
		wave += 1

func spawn() -> void:
	var pick: int = randi_range(1,6)
	var enem_inst:CharacterBody2D = null
	
	if pick < 4 or wave == 1 and pick < 7:
		enem_inst = light.instantiate()
	if pick < 6 and wave > 1 and pick > 3 or pick == 6 and wave == 2:
		enem_inst = medium.instantiate()
	if pick == 6 and wave > 2:
		enem_inst = heavy.instantiate()
	
	enem_inst.global_position = global_position + Vector2(randf_range(-100,100),0)
	enem_inst.spawner = self
	get_parent().add_child(enem_inst)
	spawnsleft -= 1
	enemiesalive += 1
	print(str(enemiesalive))

func startwave() -> void:
		spawncount = 1
		var wavediv: float = wave/25
		
		spawntime = 1.4 - wavediv
		if spawntime < 0.2:
			spawntime = 0.2
		maxst = spawntime
		minst = spawntime * 0.6
		if minst < 0.18:
			minst = 0.18
		
		spawnsleft = enemiesperwave * wave
		$Timer.start()
		waverunning = true
