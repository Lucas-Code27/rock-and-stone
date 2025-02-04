extends Area2D

var i: int = 0

var camera: Camera2D

var damage: int
var explodesize: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera = get_tree().get_first_node_in_group("camera")
	
	camera.shake(1)
	$explosion.pitch_scale = randf_range(0.75,1.25)
	$explosion.play()
	
	$CPUParticles2D.emission_rect_extents.x = explodesize
	$CollisionShape2D.shape.radius = explodesize
	$Sprite2D.scale.x += explodesize/20
	$Sprite2D.scale.y += explodesize/40
	$Sprite2D/AnimationPlayer.play("fire")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if $Sprite2D/AnimationPlayer.is_playing() == false:
		queue_free()
	i += 1
	if i > 4:
		$CollisionShape2D.disabled = true


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("hurt"):
		body.hurt(damage)
