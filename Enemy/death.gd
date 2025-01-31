extends CPUParticles2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.emitting = true	

func _process(_delta: float) -> void:
	if self.emitting == false:
		queue_free()
