extends Node

var items = []

func add_item(_item,_count = 1) -> void:
	var item_index = find_item_index(_item.name)
	if item_index != -1:
		items[item_index][1] += _count
	else:
		items.append([_item,_count])
	#print(items)

func remove_item(_item_name,_count = 1) -> void:
	var item_index = find_item_index(_item_name)
	if item_index != -1:
		if items[item_index][1] != 1:
			items[item_index][1] -= _count
		else:
			items.remove_at(item_index)

func find_item_index(_item_name) -> int:
	for i in range(items.size()):
		if items[i][0].name == _item_name:
			return i
	return -1
