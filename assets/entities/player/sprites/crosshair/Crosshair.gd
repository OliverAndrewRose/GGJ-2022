extends Node2D


func _process(_delta):
	self.global_transform.origin = get_global_mouse_position();
	self.look_at(self.global_transform.origin + Vector2(0,2));
	pass
