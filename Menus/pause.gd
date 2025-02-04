extends Control

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused == false:
			$pause.pitch_scale = 1
			$pause.play()
			get_tree().paused = true
			visible = true
			move_to_front()
		else:
			get_tree().paused = false
			visible = false
			$pause.pitch_scale = 0.8
			$pause.play()
