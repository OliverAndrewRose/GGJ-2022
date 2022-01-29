extends RigidBody2D
class_name Projectile

var damage: int = 10;

func on_collision(body: Node2D):
	give_damage(body);
	pass


func give_damage(body: Node2D):
	
	if body.has_node("Health"):
		body.get_node("Health").take_damage(damage);
