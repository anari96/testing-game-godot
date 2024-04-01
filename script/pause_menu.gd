extends Control

@export var player:CharacterBody3D
@onready var quit_button = $HSplitContainer/SideNavigation/Quit

func _ready():
	quit_button.pressed.connect(quit)

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		if player.is_pausing:
			player.is_freelook = true
			player.is_pausing = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			hide()
		elif !player.is_pausing :
			player.is_freelook = false
			player.is_pausing = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			show()

func _physics_process(delta):
	if player.is_pausing:
		Engine.time_scale = 1.0
	elif !player.is_pausing:
		Engine.time_scale = 1.0

func quit():
	get_tree().quit()

func resume():
	player.is_pausing = false

func _on_resume_button_pressed():
	resume()

func _on_quit_button_pressed():
	quit()
