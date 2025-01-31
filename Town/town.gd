extends Area2D

var spawner: Marker2D
var camera:Camera2D

var hud:Control

@onready var losescreen: PackedScene = preload("res://Menus/You_Lose.tscn")

var health: int = 50
var maxhealth: int = 50
var defense: float = 0
var ecom: int = 20

var ore: int = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawner = get_tree().get_first_node_in_group("spawner")
	hud = get_tree().get_first_node_in_group("Hud")
	camera = get_tree().get_first_node_in_group("camera")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		var damage: int = round(body.damage - defense)
	
		if damage < 1:
			damage = 1
	
		health -= damage
		call_deferred("update_hud")
		spawner.enemiesalive -= 1
		body.queue_free()
		camera.shake(0.25)
		$hit.pitch_scale = randf_range(0.8,1)
		$hit.play()

func update_hud() -> void:
	hud.health = health
	hud.ore = ore
	hud.maxhealth = maxhealth
	hud.update_hud()
	if health < 1:
		get_tree().change_scene_to_packed(losescreen)

func money(wave: int) -> void:
	ore += ecom + wave*10
	hud.ore = ore
	hud.update_hud()

func check_health() -> bool:
	if health > maxhealth:
		health = maxhealth
		return true
	if health == maxhealth:
		return true
	else:
		return false
