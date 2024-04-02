extends Node

var items = []

func add_item(_item,_count) -> void:
	items.append([_item,_count])
	print(items)

func remove_item(_item_name) -> void:
	items.find(_item_name)

func find_item_index(_item_name) -> int:
	for i in range(items.size()):
		if items[i].find(_item_name) != -1:
			return i
	return -1
