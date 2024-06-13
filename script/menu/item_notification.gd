extends VBoxContainer

@onready var notification_base = load("res://scene/menu/notification.tscn")

func new_notification(item_name:String):
	var notification = notification_base.instantiate()
	print("Added " + item_name + " to inventory")
	print(notification.get_node("Label"))
	notification.get_node("Label").text = "Added " + item_name + " to inventory"
	add_child(notification)
