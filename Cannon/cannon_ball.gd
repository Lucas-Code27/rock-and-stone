extends Area2D

var speed: float = 25
var dir: float

var damage: int
var explodesize: int

var particle: PackedScene = preload("res://Cannon/CannonExplode.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	global_position += Vector2.RIGHT.rotated(dir) * speed

func particle_spawn() -> void:
	var part_inst:Area2D = particle.instantiate()
	part_inst.global_position = global_position
	part_inst.damage = damage
	part_inst.explodesize = explodesize
	get_parent().add_child(part_inst)

func _on_body_entered(_body: Node2D) -> void:
	call_deferred("particle_spawn")
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
