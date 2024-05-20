extends Control

func _input(event):
	if Input.is_action_just_pressed("ui_cancel") && PlayerManager.current_player.is_talking == true:
		close()

func open():
	$ScrollContainer/DialogueList.populate()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	PlayerManager.current_player.is_pausing = true
	PlayerManager.current_player.is_freelook = false
	PlayerManager.current_player.component.get_node("move").disable_input = true
	show()

func close():
	hide()
