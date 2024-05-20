extends Button

@export var topic : Resource

# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(_on_pressed)
	text = str(topic.topic)

func _on_pressed():
	DialogueManager.start_text(topic.text)
	DialogueManager.current_dialogue = topic
	PlayerManager.current_player.subtitle_container.dialogue_list_container.hide()
	#DialogueManager.current_npc.audio_streamer.stream = topic.sound
	#DialogueManager.current_npc.audio_streamer.play()
	#topic.dialogue_effect()
