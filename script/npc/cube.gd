extends Area3D

@export var npc_id = "cube01"
@export var initial_dialogue : Resource
@onready var audio_streamer = $AudioStreamPlayer3D

func talk():
	PlayerManager.current_player.subtitle_container.dialogue_list_container.show()
	DialogueManager.get_topic(npc_id, self)
	PlayerManager.current_player.is_talking = true
	DialogueManager.start_text(initial_dialogue.text)
	DialogueManager.current_dialogue = initial_dialogue
