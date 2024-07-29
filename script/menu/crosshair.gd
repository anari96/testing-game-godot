extends CanvasLayer

@export var top : Line2D
@export var left : Line2D
@export var bottom : Line2D
@export var right : Line2D

var crosshair_multiplier = 800.0

func change_crosshair(current_spread):
	var tween = get_tree().create_tween()
	var crosshair_spread = current_spread * crosshair_multiplier 
	var speed = 0.1
	tween.parallel().tween_property(left,"position:x", crosshair_spread * -1, speed)
	tween.parallel().tween_property(right,"position:x", crosshair_spread * 1, speed)
	tween.parallel().tween_property(bottom,"position:y", crosshair_spread * 1, speed)
	tween.parallel().tween_property(top,"position:y", crosshair_spread * -1, speed)
	
	#left.position.x = crosshair_spread * -1
	#right.position.x = crosshair_spread * 1
	#bottom.position.y = crosshair_spread * 1
	#top.position.y = crosshair_spread * -1
