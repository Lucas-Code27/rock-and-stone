extends Node2D

var waveinprogress: bool = false
var defending: bool = false
var spawner: Marker2D
var camera: Camera2D
var town: Area2D
var hud:Control

var paid: bool = true
var started: bool = false
var towned: bool = false

var damage: int
var expsize: int

var ecom: int
var maxhp: int
var hp: int

var damagecost: int = 20
var sizecost: int = 30
var ecomcost: int = 25
var maxhpcost:int = 20
var repaircost: int = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawner = get_tree().get_first_node_in_group("spawner")
	camera = get_tree().get_first_node_in_group("camera")
	town = get_tree().get_first_node_in_group("town")
	hud = get_tree().get_first_node_in_group("Hud")
	
	$townmusic.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	waveinprogress = spawner.waverunning
	
	if waveinprogress == true or spawner.enemiesalive > 0:
		if camera.global_position != Vector2(300,0):
			camera.global_position = Vector2(300,0)
			defending = true
			if started == false:
				started = true
				$fight.play()
				$townmusic.stop()
				towned = false
	else:
		if camera.global_position != Vector2(-253,0):
			camera.global_position = Vector2(-253,0)
			if towned == false:
				$townmusic.play()
				towned = true
			if paid == false:
				town.money(spawner.wave)
				hud.wave += 1
				hud.update_hud()
				paid = true
				$Payday.play()
				$fight.stop()
				started = false
			defending = false
	
	if defending == true and waveinprogress == false:
		if spawner.enemiesalive == 0:
			spawner.startwave()
			paid = false
