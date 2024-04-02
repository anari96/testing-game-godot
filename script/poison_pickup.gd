extends Area3D

@export var item:Item

func use():
	InventoryManager.add_item(item,1)
	queue_free()
