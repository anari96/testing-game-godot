extends Node3D

var equip_index = 0

var max_equip = 2

var previous_equip_index
var mouse_movement : Vector2

func _input(event):
	if event is InputEventMouseMotion:
		mouse_movement = event.relative
	if Input.is_action_just_pressed("use1"):
		if get_child(equip_index) != null:
			get_child(equip_index).use1()
	
	if Input.is_action_just_pressed("scroll_down"):
		prev_equip(equip_index)
	if Input.is_action_just_pressed("scroll_up"):
		next_equip(equip_index)

func select_equip(index):
	if get_child(index) != null:
		get_child(index).equip()
	
func remove_equip(index):
	if get_child(index) != null:
		get_child(index).remove()

func prev_equip(index):
	remove_equip(equip_index)
	if equip_index <= 0:
		equip_index = max_equip
	else:
		equip_index -= 1
	select_equip(equip_index)

func next_equip(index):
	remove_equip(equip_index)
	if equip_index == max_equip:
		equip_index = 0
	else:
		equip_index += 1
	select_equip(equip_index)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
