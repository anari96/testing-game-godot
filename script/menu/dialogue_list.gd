extends VBoxContainer

@export var player:CharacterBody3D
@onready var topic_base = preload("res://scene/menu/topic.tscn")

func empty():
	var children = get_children()
	for i in range(children.size()):
		children[i].queue_free()

func populate():
	empty()
	var topics = DialogueManager.current_topic
	print(topics)
	for i in range(topics.size()):
		var topic = topic_base.instantiate()
		topic.topic = topics[i]
		add_child(topic)
	#print(topics)
