extends KinematicBody

var explosion = preload("res://weapons/Explosion.tscn")

var speed = 40
var impact_damage = 20
var exploded = false

func _ready():
	hide()
	
func set_bodies_to_exclude(bodies_to_exclude : Array):
	for body in bodies_to_exclude:
		add_collision_exception_with(body)
		
func _physics_process(delta):
	var collision : KinematicCollision = move_and_collide(-global_transform.basis.z * speed * delta)
	if collision:
		var collider = collision.collider
		if collider.has_method("hurt"):
			collider.hurt(impact_damage, -global_transform.basis.z)
		explode()
		
func explode():
	if exploded:
		return
	exploded = true
	speed = 0
	$CollisionShape.disabled = true
	var explosion_inst = explosion.instance()
	get_tree().get_root().add_child(explosion_inst)
	explosion_inst.global_transform.origin = global_transform.origin
	explosion_inst.explode()
	$SmokeTrail.emitting = false
	$Graphics.hide()
	$DestroyAfterHitTimer.start()
