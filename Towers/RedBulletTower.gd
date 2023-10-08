extends StaticBody2D

var Bullet = preload("res://Towers/RedBullet.tscn")
var bulletDamage = 5
var pathName
var currTargets = [] #targets on our area
var curr


func _on_tower_body_entered(body):
	if "SoldierA" in body.name:
		var tempArray = []
		currTargets = get_node("Tower").get_overlapping_bodies()
		#another loop on targets asking to compare the progress of Soldiers , which is in it's parent (PathSpawner)... looking the hit the first (more advanced)
		# if the list is empty, aim the first
		#add an iterative for loop to add enemies to our tempArray
		for i in currTargets:
			if "Soldier" in i.name:
				tempArray.append(i)
				
		var currTarget = null
		
		for i in tempArray:
			if currTarget == null:
				currTarget = i.get_node("../")
				# in this line you choose the preference of your selected tower(attack first|attack farest)
			else:
				if i.get_parent().get_progress() > currTarget.get_progress():
					currTarget = i.get_node("../")
		# we will make a distinction between these
		curr = currTarget
		#aiming Path2D
		pathName = currTarget.get_parent().name
		
		var tempBullet = Bullet.instantiate()
		tempBullet.pathName = pathName
		tempBullet.bulletDamage = bulletDamage
		get_node("BulletContainer").add_child(tempBullet)
		tempBullet.global_position = $Aim.global_position
		
		
func _on_tower_body_exited(body):
	currTargets = get_node("Tower").get_overlapping_bodies()
