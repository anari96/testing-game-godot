extends Node



var dialogue_path = "res://resource/dialogue/"
var current_npc
var current_topic = []
var current_dialogue
var current_text = []
var current_text_line = 0
var is_in_dialogue = false

func get_topic(npc_id,npc):
	current_topic.clear()
	current_npc = npc
	var npc_dialogue_path = dialogue_path + npc_id
	var dir = DirAccess.open(npc_dialogue_path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				
				print("Found directory: " + file_name)
			else:
				var topic = load(npc_dialogue_path + "/" + file_name)
				current_topic.push_back(topic)
				print("Found file: " + file_name)
			file_name = dir.get_next()
		#print(current_topic)
	else:
		print("An error occurred when trying to access the path.")

func start_text(text = []):
	print(current_topic)
	current_text_line = 0
	current_text = text
	PlayerManager.current_player.subtitle_container.show()

	PlayerManager.current_player.subtitle_container.subtitle.text = current_text[current_text_line]

func stop_text():
	current_text_line = 0
	current_text = []
	PlayerManager.current_player.subtitle_container.hide()

func next_text():
	if current_text_line == (current_text.size() - 1):
		current_text_line = 0
		current_text = []
		current_dialogue.dialogue_effect()
		PlayerManager.current_player.subtitle_container.hide()
		PlayerManager.current_player.subtitle_container.dialogue_list_container.show()
	elif current_text_line < (current_text.size() - 1):
		current_text_line += 1
		PlayerManager.current_player.subtitle_container.subtitle.text = current_text[current_text_line]
