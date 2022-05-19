extends Area

signal got_pickup

var max_player_health = 0
var cur_player_health = 0

func update_player_health(amnt):
	cur_player_health + amnt
	
func _ready():
	connect("area_entered",self, "on_area_enter")
	
func on_area_enter(pickup: Pickup):
	if pickup.pickup_type == Pickup.PICKUP_TYPES.HEALTH and cur_player_health == max_player_health:
		return
	emit_signal("got_pickup", pickup.pickup_type, pickup.ammo)
	pickup.queue_free()
