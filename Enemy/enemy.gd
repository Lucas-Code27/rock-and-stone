extends CharacterBody2D

var spawner: Marker2D

@onready var part: PackedScene = preload("res://Enemy/death.tscn")

var accel: int
var maxspeed: int
var hp: int
var maxhp:int
var recovery:int
var damage:int
var weight:int

var deltatime: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D/AnimationPlayer.play("walking")
	
	accel = get_meta("acceleration") + spawner.wave/2
	maxspeed = get_meta("maxspeed") + spawner.wave
	maxhp = get_meta("maxhp") + spawner.wave/5
	recovery = get_meta("recovery") + spawner.wave/2
	damage = get_meta("damage") + spawner.wave/5
	weight = get_meta("weight") + spawner.wave/2
	hp = maxhp
	
	if weight > 200:
		weight = 200

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	deltatime = delta
	
	velocity.x += accel * delta * -1
	velocity.y += get_gravity().y * delta
	if is_on_floor() and velocity.y > 0:
		velocity.y = 0
	if is_on_floor() and velocity.x > 0:
		velocity.x -= recovery
	if velocity.x < -maxspeed:
		velocity.x = -maxspeed
	move_and_slide()

func hurt(damage:int) -> void:
	$hurt.play()
	hp -= damage
	if hp < 1:
		spawner.enemiesalive -= 1 
		var part_inst = part.instantiate()
		part_inst.global_position = global_position
		get_parent().add_child(part_inst)
		queue_free()
	else:
		velocity = Vector2((200)-weight,((-get_gravity().y * 25) * deltatime)-weight)

#func _on_area_2d_area_entered(area: Area2D) -> void:
	#if area.is_in_group("playerattack"):
		#$hurt.play()
		#hp -= area.damage
		#if hp < 1:
			#spawner.enemiesalive -= 1 
			#
			#var part_inst = part.instantiate()
			#part_inst.global_position = global_position
			#get_parent().add_child(part_inst)
			#
			#queue_free()
		#else:
			#velocity = Vector2((200)-weight,((-get_gravity().y * 25) * deltatime)-weight)
