extends VBoxContainer

@onready var item_base = preload("res://scene/menu/item.tscn")

func empty():
	var children = get_children()
	for i in range(children.size()):
		children[i].queue_free()

func populate():
	#get_children().queue_free()
	empty()
	var items = InventoryManager.items
	for i in range(items.size()):
		var item = item_base.instantiate()
		item.item = items[i][0]
		item.item_count = items[i][1]
		add_child(item)
	#print(items)
