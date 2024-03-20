extends Weapon

@onready var animation_player = $sword/AnimationPlayer
@onready var cooldown_timer = $cooldownTimer
@onready var attack_level_cooldown_timer = $attackLevelCooldownTimer
@onready var hurtbox = $hurtbox
@onready var hand_parent = get_parent()


const stamina_usage = 27
var can_use : bool = true
var attack_level = 1

@export var damage = 33

func _ready():
	animation_player.play("idle")
	cooldown_timer.timeout.connect(_cooldown_timer_timeout)
	attack_level_cooldown_timer.timeout.connect(_attack_level_cooldown_timer_timeout)
	hurtbox.body_entered.connect(_on_hurtbox_body_entered)

func use1() -> void:
	if can_use == true && hand_parent.stamina.stamina >= stamina_usage:
		hand_parent.stamina.damage(27)
		can_use = false
		
		attack()
		attack_level += 1
		attack_level_cooldown_timer.start()
		cooldown_timer.start()

func attack():
	var animation
	match attack_level:
		1:
			animation = "attack1"
		2:
			animation = "attack2"
		3:
			animation = "attack3"
		_:
			attack_level = 1
			animation = "attack1"
			
	play_animation(animation)

func play_animation(animation):
	if animation_player.is_playing() == true:
		animation_player.stop()
		animation_player.play(animation)
	else:
		animation_player.play(animation)

func use2() -> void:
	pass

func equip() -> void:
	animation_player.play("equip")
	var equipped = true
	show()
	
func remove() -> void:
	var equipped = false
	hide()

func _cooldown_timer_timeout():
	can_use = true

func _attack_level_cooldown_timer_timeout():
	attack_level = 1

func _on_hurtbox_body_entered(body):
	if body.is_in_group("enemy") :
		body.damage(damage,Vector3(0,0,10.0))
