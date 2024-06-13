extends MarginContainer

@onready var label = $Label
@onready var timer = $Timer

func _ready():
	timer.timeout.connect(_on_timer_timeout)
	timer.start()

func _on_timer_timeout():
	queue_free()
