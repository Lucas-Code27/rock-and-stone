extends Control

var town:Area2D
var spawner:Marker2D

var health:int
var maxhealth:int
var ore:int
var wave:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	town = get_tree().get_first_node_in_group("town")
	spawner = get_tree().get_first_node_in_group("spawner")
	
	health = town.health
	maxhealth = town.maxhealth
	ore = town.ore
	wave = spawner.wave
	
	$Ore.text = "Ore: " + str(ore)
	$Health.text = "Health: " + str(health) + "/" + str(maxhealth)
	$Wave.text = "Wave " + str(wave)


func update_hud():
	$Ore.text = "Ore: " + str(ore)
	$Health.text = "Health: " + str(health) + "/" + str(maxhealth)
	$Wave.text = "Wave " + str(wave)
