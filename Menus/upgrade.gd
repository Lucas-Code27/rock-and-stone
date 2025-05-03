extends Control

var cannon: Sprite2D
var town: Area2D

var storage: Node2D

var parent: Control

var damage: int
var expsize: int

var ecom: int
var maxhp: int
var hp: int

var damagecost: int
var sizecost: int
var ecomcost: int
var maxhpcost:int
var repaircost: int

func _ready() -> void:
	cannon = get_parent().get_parent().get_node("Cannon")
	damage = cannon.damage
	expsize = cannon.explodesize
	
	town = get_parent().get_parent().get_node("Town")
	ecom = town.ecom
	hp = town.health
	maxhp = town.maxhealth
	
	storage = get_parent().get_parent()
	damagecost = storage.damagecost
	sizecost = storage.sizecost
	ecomcost = storage.ecomcost
	maxhpcost = storage.maxhpcost
	repaircost = storage.repaircost
	
	$Damage.text = "Damage " + "Cost: " + str(damagecost)
	$MaxHealth.text = "Town Health " + "Cost: " + str(maxhpcost)
	$Explosionsize.text = "Explosion Size " + "Cost: " + str(sizecost)
	$Economy.text = "Mining " + "Cost: " + str(ecomcost)
	
	if hp == maxhp:
		$Repair.text = "Repair " + "Fully Repaired"
		$Repair.disabled = true
	else:
		$Repair.text = "Repair " + "Cost: " + str(repaircost)


func _on_exit_pressed() -> void:
	storage.damagecost = damagecost
	storage.sizecost = sizecost
	storage.ecomcost = ecomcost
	storage.maxhpcost = maxhpcost
	storage.repaircost = repaircost
	parent.upgrade_closed()
	queue_free()


func _on_damage_pressed() -> void:
	if damagecost < town.ore or damagecost == town.ore:
		cannon.damage += 1
		damage += 1
		town.ore -= damagecost
		damagecost += round(damagecost/1.5)
		town.update_hud()
		$Damage.text = "Damage " + "Cost: " + str(damagecost)
		$pay.play()
	else:
		$nopay.play()


func _on_max_health_pressed() -> void:
	if maxhpcost < town.ore or maxhpcost == town.ore:
		town.maxhealth += 10
		town.health += 10
		maxhp += 10
		town.ore -= maxhpcost
		maxhpcost += round(maxhpcost/1.5)
		town.update_hud()
		$MaxHealth.text = "Town Health " + "Cost: " + str(maxhpcost)
		$pay.play()
	else:
		$nopay.play()


func _on_repair_pressed() -> void:
	if repaircost < town.ore or repaircost == town.ore:
		town.health += 10
		hp += 10
		if town.check_health() == true:
			town.update_hud()
			$Repair.text = "Repair " + "Fully Repaired"
			$Repair.disabled = true
		else:
			town.ore -= repaircost
			repaircost += round(repaircost/2)
			town.update_hud()
			$Repair.text = "Repair " + "Cost: " + str(repaircost)
			$pay.play()
	else:
		$nopay.play()


func _on_explosionsize_pressed() -> void:
	if sizecost < town.ore or sizecost == town.ore:
		cannon.explodesize += 5
		expsize += 5
		town.ore -= sizecost
		sizecost += round(sizecost/1)
		town.update_hud()
		$Explosionsize.text = "Explosion Size " + "Cost: " + str(sizecost)
		$pay.play()
	else:
		$nopay.play()

func _on_economy_pressed() -> void:
	if ecomcost < town.ore or ecomcost == town.ore:
		town.ecom += 15
		ecom += 15
		town.ore -= ecomcost
		ecomcost += round(ecomcost/1.75)
		town.update_hud()
		$Economy.text = "Mining " + "Cost: " + str(ecomcost)
		$pay.play()
	else:
		$nopay.play()
