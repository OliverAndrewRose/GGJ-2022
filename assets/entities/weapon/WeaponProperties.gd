extends Node
class_name WeaponProperties

export(int) var damage: int;
export(int) var bullet_speed: int;
export(PackedScene) var bullet_scene: PackedScene;

export(bool) var is_pump_action: bool = true;
export(float) var pump_delay: float = 0.5;

onready var shoot = get_node("../../PlayerShoot");

func is_current_weapon() -> bool:
	if shoot.current_weapon == self:
		return true;
	return false;
