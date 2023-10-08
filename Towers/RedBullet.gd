extends CharacterBody2D

var target
var Speed = 1000
var pathName = ""
var bulletDamage 

func _physics_process(delta):
	
	#aim at the unique named pathway of soldier - COMMON EASY ACCESS TECHNIQUE
	var pathSpawnerNode = get_tree().get_root().get_node("Main/PathSpawner")
	
	for i in pathSpawnerNode.get_child_count():
		if pathSpawnerNode.get_child(i).name == pathName:
			target = pathSpawnerNode.get_child(i).get_child(0).get_child(0).global_position
	
	#constantly updating target's position
	velocity = global_position.direction_to(target) *Speed

	look_at(target)
	
	move_and_slide()

func _on_area_2d_body_entered(body):
	if "SoldierA" in body.name:
		body.Health -= bulletDamage
		queue_free()
