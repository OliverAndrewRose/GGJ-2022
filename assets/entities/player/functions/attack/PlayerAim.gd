extends Node2D
class_name PlayerAim

onready var _cam_node: Camera2D = get_node(camera);
export(int) var aim_min_distance: int = 30;
export(NodePath) var camera: NodePath;

var is_aiming: bool = false;
onready var aim_node: Node2D = $aim_position as Node2D;

func _ready() -> void:
	$aim_position/crosshair.visible = false;

func _process(delta) -> void:
	aim_node.transform.origin = _calculate_aim_direction();
	aim_node.look_at(aim_node.global_position + _calculate_aim_direction())
	_process_aim_move_speed();
	

func _input(event) -> void:
	if event.is_action_pressed("aim"):
		aim_weapon();
	if event.is_action_released("aim"):
		lower_weapon();

func aim_weapon() -> void:
	$aim_position/crosshair.visible = true;
	is_aiming = true;

func lower_weapon() -> void:
	$aim_position/crosshair.visible = false;
	is_aiming = false;


func _calculate_aim_direction() -> Vector2:
	var _mouse_pos: Vector2 = get_global_mouse_position();
	return (_mouse_pos - self.global_transform.origin).normalized() * aim_min_distance;


func _process_aim_move_speed():
	var _movement: PlayerMovement = get_node("../../Movement") as PlayerMovement;
	
	if is_aiming:
		_movement.can_run = false;
	else:
		_movement.can_run = true;
