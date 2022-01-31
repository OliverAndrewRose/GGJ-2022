extends Node
class_name PlayerMovement

export(float) var walk_speed: float = 5000.0;
export(float) var run_speed: float = 10000.0;
export(float) var speed: float = walk_speed;

var is_moving: bool = false;
var is_running: bool = false;
var can_run: bool = true;

var current_direction: Vector2;
onready var player_root: KinematicBody2D = get_node("../..") as KinematicBody2D;


func _process(delta):
	_process_movement(delta)
	pass

# Processes the movement.
func _process_movement(delta):
	
	var _movement_dir = Vector2(0,0);
	is_moving = false;
	
	if Input.is_action_pressed("walk up"):
		_movement_dir.y = -1.0;
	if Input.is_action_pressed("walk down"):
		_movement_dir.y = 1.0;
	if Input.is_action_pressed("walk left"):
		_movement_dir.x = -1.0;
	if Input.is_action_pressed("walk right"):
		_movement_dir.x = 1.0;
	
	_process_sprint();
	current_direction = _movement_dir;
	
	if _movement_dir != Vector2(0,0):
		is_moving = true;
	
	player_root.move_and_slide(_movement_dir * speed * delta)
	pass


func _process_sprint():
	if Input.is_action_pressed("run") and can_run:
		speed = run_speed;
		is_running = true;
	else:
		speed = walk_speed;
		is_running = false;
