extends ItemPickup

@export var spawner:Node3D

func use():
	FactManager.add_fact("pickup_item",spawner.get_path(),true)
	InventoryManager.add_item(item)
	queue_free()
