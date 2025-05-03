extends Area2D

@export var spawner: Marker2D
@export var camera:Camera2D

@export var hud:Control

@onready var losescreen: PackedScene = preload("res://Menus/You_Lose.tscn")

var health: int = 50
var maxhealth: int = 50
var ecom: int = 20

var ore: int = 100

func _on_body_entered(body: Node2D) -> void:
	if body.is_class("CharacterBody2D"):
		var damage: int = body.damage
	
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
	ore += ecom + round(pow(wave*10,1.2))
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
