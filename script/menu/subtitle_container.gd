extends PanelContainer

@export var subtitle: Label
@export var dialogue_list_container:Control

func _input(event):
	if PlayerManager.current_player.is_talking == true:
		if Input.is_action_just_pressed("use1"):
			DialogueManager.next_text()
