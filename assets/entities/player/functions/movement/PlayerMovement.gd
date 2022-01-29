extends Node
class_name PlayerMovement

export(float) var walk_speed: float = 5000.0;
export(float) var run_speed: float = 10000.0;
export(float) var speed: float = walk_speed;

var current_direction: Vector2;
onready var player_root: KinematicBody2D = get_node("../..") as KinematicBody2D;


func _process(delta):
	_process_movement(delta)
	pass

# Processes the movement.
func _process_movement(delta):
	
	var _movement_dir = Vector2(0,0);
	if Input.is_action_pressed("walk up"):
		_movement_dir.y = -1.0;
	if Input.is_action_pressed("walk down"):
		_movement_dir.y = 1.0;
	if Input.is_action_pressed("walk left"):
		_movement_dir.x = -1.0;
	if Input.is_action_pressed("walk right"):
		_movement_dir.x = 1.0;
		
	current_direction = _movement_dir;
	player_root.move_and_slide(_movement_dir * speed * delta)
	pass
