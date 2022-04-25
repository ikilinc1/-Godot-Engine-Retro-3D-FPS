extends KinematicBody

onready var anim_player = $Graphics/AnimationPlayer
onready var health_manager = $HealthManager

enum STATES {IDLE, CHASE, ATTACK, DEAD}
var cur_state = STATES.IDLE

var player = null

export var sight_angle = 45.0

func _ready():
	player = get_tree().get_nodes_in_group("player")[0]
	var bone_attachments = $Graphics/Armature/Skeleton.get_children()
	for bone_attachment in bone_attachments:
		for child in bone_attachment.get_children():
			if child is HitBox:
				child.connect("hurt", self, "hurt")
				
	health_manager.connect("dead", self, "set_state_dead")
	set_state_idle()


func _process(delta):
	match cur_state:
		STATES.IDLE:
			process_state_idle(delta)
		STATES.CHASE:
			process_state_chase(delta)
		STATES.ATTACK:
			process_state_attack(delta)
		STATES.DEAD:
			process_state_dead(delta)
			
func set_state_idle():
	cur_state = STATES.IDLE
	anim_player.play("idle_loop")
	
func set_state_chase():
	cur_state = STATES.CHASE
	
func set_state_attack():
	cur_state = STATES.ATTACK
	
func set_state_dead():
	cur_state = STATES.DEAD
	anim_player.play("die")
	
func process_state_idle(delta):
	if can_see_player():
		set_state_chase()
	
func process_state_chase(delta):
	pass
	
func process_state_attack(delta):
	pass
	
func process_state_dead(delta):
	pass

func hurt(damage: int, dir: Vector3):
	if cur_state == STATES.IDLE:
		set_state_chase()
	health_manager.hurt(damage, dir)
	
	
func can_see_player():
	var dir_to_player = global_transform.origin.direction_to(player.global_transform.origin)
	var forwards = global_transform.basis.z
	return rad2deg(forwards.angle_to(dir_to_player)) < sight_angle and has_los_player()

func has_los_player():
	var our_pos = global_transform.origin + Vector3.UP
	var player_pos = player.global_transform.origin + Vector3.UP
	
	var space_state = get_world().get_direct_space_state()
	var result = space_state.intersect_ray(our_pos,player_pos,[],1)
	if result:
		return false
	return true
	
func alert(check_los = true):
	if cur_state != STATES.IDLE:
		return
	if check_los and !has_los_player():
		return
	set_state_chase()
	
	
	
	
	
	
	
	
	
	
	
	
	
