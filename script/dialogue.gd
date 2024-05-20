extends Resource
class_name Dialogue

@export var actor_id:String = "actor_name"
@export var topic:String = "greeting"
@export var text:Array[String]
@export var disabled:bool
@export var sound:Array[AudioStream]
@export var follow_up:Array[Dialogue] = []
@export var effect : Resource = load("res://script/dialogue/topic_effect_base.gd").new()

func dialogue_effect():
	effect.effect()
