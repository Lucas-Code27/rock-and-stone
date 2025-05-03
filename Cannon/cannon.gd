extends Sprite2D

const ball: PackedScene = preload("res://Cannon/CannonBall.tscn")

@export var coolui: Control
@export var town: Area2D
@export var gamestate: Node2D

@export var camera: Camera2D

var damage:int = 1
var explodesize: int = 50
var cooldown:float = 0.2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$cooldown.wait_time = cooldown


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if gamestate.defending == true:
		look_at(get_global_mouse_position())
		$Marker2D/Line2D.visible = true
	
		if Input.is_action_just_pressed("fire") and $cooldown.time_left == 0 and town.ore > 0:
			fire()
			town.ore -= 1
			town.update_hud()
		if Input.is_action_just_pressed("fire") and town.ore == 0:
			$nofire.play()
	else:
		global_rotation = 0
		$Marker2D/Line2D.visible = false
		
func fire() -> void:
	var ball_inst:Area2D = ball.instantiate()
	ball_inst.global_position = $Marker2D.global_position
	ball_inst.dir = rotation
	ball_inst.damage = damage
	ball_inst.explodesize = explodesize
	get_parent().add_child(ball_inst)
	coolui.start_timer()
	$cooldown.start()
	$fire.pitch_scale = randf_range(0.35,0.6)
	$fire.play()
	camera.shake(0.8)

func verify_cool() -> bool:
	if cooldown < 0.1:
		cooldown = 0.1
		return true
	else:
		return false
