extends Node

#var facts = []
var facts = []

func add_fact(fact_name:String,node,parameter):
	facts.push_front([fact_name,node,parameter])
	print(facts)

func get_fact(fact_name:String):
	for i in range(facts.size()):
		if facts[i][0] == fact_name:
			return facts[i]
	return -1

func set_fact(fact_name:String,node,paramater):
	for i in range(facts.size()):
		if facts[i][0] == fact_name:
			facts[i][2] = paramater
			facts[i][1] = node
			return facts[i][0]
	return -1

func apply_fact():
	for i in range(facts.size()):
		if facts[i][0] == "pickup_item":
			var node = get_tree().get_root().get_node(facts[i][1])
			if node != null:
				node.can_spawn = false
			#print("node")
