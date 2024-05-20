extends DialogueEffect

static func effect() -> void:
	var health = load("res://resource/Health.tres")
	InventoryManager.add_item(health)
