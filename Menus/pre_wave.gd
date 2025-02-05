extends Control

var upmen:PackedScene = preload("res://Menus/Upgrade.tscn")

@export var gamestate: Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if gamestate.defending == false:
		visible = true
		await $Nextwave.pressed
		gamestate.defending = true
		$select.play()
	else:
		visible = false


func _on_upgrades_pressed() -> void:
	var upmen_inst = upmen.instantiate()
	upmen_inst.parent = self
	get_parent().add_child(upmen_inst)
	$select.play()

func upgrade_closed() -> void:
	$upgrade.play()
