extends Control


@onready var level: PackedScene = preload("res://Test_Map.tscn")

func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(level)
