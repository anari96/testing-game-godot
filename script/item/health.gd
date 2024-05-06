extends ItemEffect

static func effect() -> void:
	print("Heals you")
	PlayerManager.current_player.hurt(-10)
