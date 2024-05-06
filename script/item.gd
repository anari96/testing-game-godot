extends Resource
class_name Item

enum ITEM_TYPE {CONSUMABLE,KEY,EQUIPMENT}
@export var name:String = "item_name"
@export var type: ITEM_TYPE = ITEM_TYPE.CONSUMABLE
@export var description: String = "Description"
@export var heal_value: int = 0
@export var effect : Resource = load("res://script/item/item_effect_base.gd").new()

func use() -> void:
	print("used item : " + name)
	effect.effect()
