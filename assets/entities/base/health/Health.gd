extends Node
class_name Health

var _current_health: int = 100;
var max_health: int = 100;

signal on_death()

func take_damage(damage: int):
	_current_health -= damage;
	
	if _current_health <= 0:
		emit_signal("on_death");
