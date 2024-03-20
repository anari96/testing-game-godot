extends Node3D

var parent : Player

@export var camera:Camera3D

func jump():
	var tween = create_tween()
	tween.tween_property(camera,"rotation:x", deg_to_rad(-3.5), 0.2).set_trans(Tween.TRANS_SPRING)
	tween.tween_property(camera,"rotation:x", 0.0, 1.0).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)

func fall():
	var tween = create_tween()
	tween.tween_property(camera,"rotation:x", deg_to_rad(-3.5), 0.1).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(camera,"rotation:x", 0.0, 0.6).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
