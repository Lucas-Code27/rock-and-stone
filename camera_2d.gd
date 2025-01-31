extends Camera2D

@export var randstrength: float = 30
@export var fade: float = 30

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

var shakestrength: float = 0

func shake(mult: float) -> void:
	shakestrength = randstrength * mult

func _process(delta: float) -> void:
	if shakestrength > 0:
		shakestrength = lerpf(shakestrength,0,fade * delta)
		
		offset = randoffset()

func randoffset() -> Vector2:
	return Vector2(rng.randf_range(-shakestrength,shakestrength),rng.randf_range(-shakestrength,shakestrength))
