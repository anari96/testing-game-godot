extends Control

@export var player:CharacterBody3D
@onready var quit_button = $HSplitContainer/SideNavigation/Quit

func _ready():
	quit_button.pressed.connect(quit)
	hide()

func _input(event):
	if Input.is_action_just_pressed("ui_cancel") && PlayerManager.current_player.is_talking == false:
		if player.is_pausing:
			hide()
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		elif !player.is_pausing :
			$HSplitContainer/VBoxContainer/item_container/item_list.populate()
			show()
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta):
	if player.is_pausing:
		Engine.time_scale = 1.0
	elif !player.is_pausing:
		Engine.time_scale = 1.0

func quit():
	get_tree().quit()

func resume():
	player.is_pausing = false
	player.move.can_move = true

func _on_resume_button_pressed():
	resume()

func _on_quit_button_pressed():
	quit()
