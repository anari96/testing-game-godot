extends ItemPickup

func use():
	InventoryManager.add_item(item)
	queue_free()
