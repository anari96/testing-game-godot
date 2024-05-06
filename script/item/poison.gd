extends ItemEffect

static func effect() -> void:
	print("Kills you")
	PlayerManager.current_player.hurt(100)
