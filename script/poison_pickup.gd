extends ItemPickup

func use():
	InventoryManager.add_item(item,1)
	queue_free()
