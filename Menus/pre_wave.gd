extends Control

var upmen:PackedScene = preload("res://Menus/Upgrade.tscn")

var gamestate: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gamestate = get_tree().get_first_node_in_group("state")


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
	get_parent().add_child(upmen_inst)
	$select.play()
