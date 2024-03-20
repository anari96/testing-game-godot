extends Area3D

@export var object:StaticBody3D
@export var target_position:Vector3

var is_triggered = false

# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(_on_body_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if is_triggered:
		object.position.y = lerp(object.position.y, -7.0, 2.0 * delta)

func _on_body_entered(body):
	if body.is_in_group("player"):
		is_triggered = true
