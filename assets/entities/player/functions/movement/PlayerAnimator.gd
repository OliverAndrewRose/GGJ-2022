extends Node
onready var movement: PlayerMovement = get_node("../Movement") as PlayerMovement;
onready var sprite: AnimatedSprite = get_node("../../sprite") as AnimatedSprite;
var _current_animation: String = "default";


func _process(delta) -> void:
	_process_movement_animation();
	_process_run_animation();

func _process_movement_animation() -> void:
	var _dir: Vector2 = movement.current_direction;
	
	# 4-way motion.
	if _dir == Vector2(1,0):
		_set_player_animation("walk_right");
	if _dir == Vector2(-1,0):
		_set_player_animation("walk_left");
	if _dir == Vector2(0,1):
		_set_player_animation("walk_downward");
	if _dir == Vector2(0,-1):
		_set_player_animation("walk_upward");
		
	# Diagonal motion.
	if _dir == Vector2(1,1):
		_set_player_animation("walk_downward");
	if _dir == Vector2(-1,1):
		_set_player_animation("walk_downward");
	if _dir == Vector2(-1,-1):
		_set_player_animation("walk_upward");
	if _dir == Vector2(1,-1):
		_set_player_animation("walk_upward");
	if _dir == Vector2(0,0):
		_set_player_animation("default");

func _set_player_animation(animation: String):
	if animation == _current_animation:
		return;
	sprite.animation = animation;
	_current_animation = animation;

func _process_run_animation():
	if movement.is_running:
		sprite.speed_scale = 2;
	else:
		sprite.speed_scale = 1;
