extends CharacterBody2D

var power: float = 100000
var dir: float

var damage: int
var explodesize: int

var particle: PackedScene = preload("res://Cannon/CannonExplode.tscn")

func _ready() -> void:
	if global_rotation < 0:
		global_rotation = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity = Vector2(power * delta,0).rotated(dir)
	move_and_slide()
	
	if $RayCast2D.is_colliding() == true:
		call_deferred("particle_spawn")
		queue_free()
	
	if $VisibleOnScreenNotifier2D.is_on_screen() == false:
		queue_free()

func particle_spawn() -> void:
	var part_inst = particle.instantiate()
	part_inst.global_position = global_position
	part_inst.damage = damage
	part_inst.explodesize = explodesize
	get_parent().add_child(part_inst)
