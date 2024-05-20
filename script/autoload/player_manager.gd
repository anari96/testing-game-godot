extends Node

@onready var player = preload("res://scene/player.tscn")
var current_player

func set_player_mode():
	pass

func _input(event):
	if Input.is_action_just_pressed("ui_cancel") && current_player.is_talking == false:
		if current_player.is_pausing:
			current_player.is_freelook = true
			current_player.is_pausing = false
			current_player.component.get_node("move").disable_input = false
			
		elif !current_player.is_pausing :
			
			current_player.is_freelook = false
			current_player.is_pausing = true
			current_player.component.get_node("move").disable_input = true
	elif Input.is_action_just_pressed("ui_cancel") && current_player.is_talking == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		current_player.is_freelook = true
		current_player.is_talking = false
		current_player.component.get_node("move").disable_input = false
		current_player.is_pausing = false
		DialogueManager.stop_text()
