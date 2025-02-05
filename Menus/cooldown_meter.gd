extends Control

@export var cannon: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TextureProgressBar.max_value = cannon.cooldown
	$Timer.wait_time = cannon.cooldown


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	global_position = Vector2(get_global_mouse_position().x,get_global_mouse_position().y - 50)
	
	$TextureProgressBar.value = $Timer.time_left

func start_timer() -> void:
	$Timer.start()
	visible = true
	await $Timer.timeout
	visible = false
