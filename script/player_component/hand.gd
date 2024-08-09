extends Node3D

var equip_index = 0

var max_equip = 2

var previous_equip_index
var mouse_movement : Vector2
@export var player : CharacterBody3D
@export var stamina : Node3D
@export var movement : Node3D
@export var camera_raycast : RayCast3D

func _process(delta):
	if !player.is_pausing:
		
		if Input.is_action_pressed("use1"):
			print("fuckwad")
			if get_child(equip_index) != null:
				get_child(equip_index).use1()
		if Input.is_action_pressed("use2"):
			if get_child(equip_index) != null:
				get_child(equip_index).use2()
		if Input.is_action_just_pressed("use3"):
			if get_child(equip_index) != null:
				get_child(equip_index).use3()
		if Input.is_action_just_pressed("key_1"):
			change_equip(0)
		elif Input.is_action_just_pressed("key_2"):
			change_equip(1)
		elif Input.is_action_just_pressed("key_3"):
			change_equip(2)

func _input(event):
	pass
	if !player.is_pausing:
		if event is InputEventMouseMotion:
			mouse_movement = event.relative
		#if Input.is_action_pressed("use1"):
			#print("fuckwad")
			#if get_child(equip_index) != null:
				#get_child(equip_index).use1()
		#if Input.is_action_pressed("use2"):
			#if get_child(equip_index) != null:
				#get_child(equip_index).use2()
		#if Input.is_action_just_pressed("use3"):
			#if get_child(equip_index) != null:
				#get_child(equip_index).use3()
		#if Input.is_action_just_pressed("key_1"):
			#change_equip(0)
		#elif Input.is_action_just_pressed("key_2"):
			#change_equip(1)
		#elif Input.is_action_just_pressed("key_3"):
			#change_equip(2)

		#if Input.is_action_just_pressed("scroll_down"):
			#prev_equip(equip_index)
		#if Input.is_action_just_pressed("scroll_up"):
			#next_equip(equip_index)

func select_equip(index):
	if get_child(index) != null:
		get_child(index).equip()

func remove_equip(index):
	if get_child(index) != null:
		get_child(index).remove()

func change_equip(index):
	remove_equip(equip_index)
	equip_index = index
	select_equip(equip_index)

func prev_equip(index):
	remove_equip(equip_index)
	if equip_index <= 0:
		equip_index = max_equip
	else:
		equip_index -= 1
	select_equip(equip_index)

func next_equip(index):
	remove_equip(equip_index)
	if equip_index >= max_equip:
		equip_index = 0
	else:
		equip_index += 1
	select_equip(equip_index)
