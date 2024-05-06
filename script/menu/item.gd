extends HBoxContainer

@export var item: Resource
var item_count:int = 1
@onready var item_count_label = $item_image/item_count
@onready var item_name_label = $item_name

func _ready():
	$item_name.pressed.connect(_on_item_pressed)
	item_count_label.text = str(item_count)	
	item_name_label.text = str(item.name)

func use():
	item.use()

func remove():
	queue_free()

func _on_item_pressed():
	use()
	InventoryManager.remove_item(item.name)
	if item_count == 1:
		
		queue_free()
	else:
		item_count -= 1
		item_count_label.text = str(item_count)
		item_name_label.text = str(item.name)
