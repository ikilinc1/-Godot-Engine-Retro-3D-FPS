extends Label

const MAX_LINES = 5
var pickups_info = []

func _ready():
	text + ""
	
func add_pickups_info(pickup_type, amount: int):
	$RemoveInfoTimer.start()
	match pickup_type:
		Pickup.PICKUP_TYPES.MACHINE_GUN:
			pickups_info.push_back("Picked up Machine Gun")
		Pickup.PICKUP_TYPES.MACHINE_GUN_AMMO:
			pickups_info.push_back("Picked up Machine Gun Ammo " + str(amount))
		Pickup.PICKUP_TYPES.SHOTGUN:
			pickups_info.push_back("Picked up Shotgun")
		Pickup.PICKUP_TYPES.SHOTGUN_AMMO:
			pickups_info.push_back("Picked up Shotgun Ammo " + str(amount))
		Pickup.PICKUP_TYPES.ROCKET_LAUNCHER:
			pickups_info.push_back("Picked up Rocket Launcher")
		Pickup.PICKUP_TYPES.ROCKET_LAUNCHER_AMMO:
			pickups_info.push_back("Picked up Rocket Launcher Ammo " + str(amount))
	while pickups_info.size() >= MAX_LINES:
		pickups_info.pop_front()
	update_display()
		
func remove_pickups_info():
	if pickups_info.size() > 0:
		pickups_info.pop_front()
	update_display()
	
func update_display():
	text = ""
	for pickups_info_text in pickups_info:
		text += pickups_info_text + "\n"
		
	
