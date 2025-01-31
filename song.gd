extends AudioStreamPlayer

var state: Node2D

@export var town: bool

var runnning : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state = get_tree().get_first_node_in_group("state")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if state.defending == true:
		pass
