extends Resource
class_name Item

enum ITEM_TYPE {CONSUMABLE,KEY,EQUIPMENT}
@export var name:String = "item_name"
@export var type: ITEM_TYPE = ITEM_TYPE.CONSUMABLE
@export var description: String = "Description"

func use() -> void:
	print("used item : " + name)
