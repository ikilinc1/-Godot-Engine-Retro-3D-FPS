extends Spatial

var hit_effect = preload("res://effects/BulletHitEffect.tscn")

export var distance = 10000
var bodies_to_exclude = []
var damage = 1

func set_damage(_damage: int):
	damage = _damage
	
func set_bodies_to_exclude(_bodies_to_exclude: Array):
	bodies_to_exclude = _bodies_to_exclude
	
func fire():
	var space_state = get_world().get_direct_space_state()
	var our_pos = global_transform.origin
	var result = space_state.intersect_ray(our_pos, our_pos - global_transform.basis.z * distance, bodies_to_exclude, 1 + 2 + 4, true, true)
	if result and result.collider.has_method("hurt"):
		result.collider.hurt(damage, result.normal)
	elif result:
		var hit_effect_inst = hit_effect.instance()
		get_tree().get_root().add_child(hit_effect_inst)
		hit_effect_inst.global_transform.origin = result.position
		
		var children : Array = hit_effect_inst.get_children()
		for child in children:
			if child is Particles:
				child.emitting = true
		
		if result.normal.angle_to(Vector3.UP) < 0.00005:
			return
		if result.normal.angle_to(Vector3.DOWN) < 0.00005:
			hit_effect_inst.rotate(Vector3.RIGHT, PI)
			return
			
		var y = result.normal
		var x = y.cross(Vector3.UP)
		var z = x.cross(y)
		
		hit_effect_inst.global_transform.basis = Basis(x, y, z)
		
