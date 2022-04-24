extends Spatial

var rocket = preload("res://weapons/Rocket.tscn")

var bodies_to_exclude = []
var damage = 1

func set_damage(_damage: int):
	damage = _damage
	
func set_bodies_to_exclude(_bodies_to_exclude: Array):
	bodies_to_exclude = _bodies_to_exclude
	
func fire():
	var rocket_inst = rocket.instance()
	rocket_inst.set_bodies_to_exclude(bodies_to_exclude)
	get_tree().get_root().add_child(rocket_inst)
	rocket_inst.global_transform = global_transform
	rocket_inst.impact_damage = damage
