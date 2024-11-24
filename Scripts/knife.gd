extends Area2D

var released: bool
var speed: int = 30
var entered: bool = false
var game_ref: Control

func _ready() -> void:
	game_ref = get_tree().get_first_node_in_group("game")
	

func _physics_process(delta: float) -> void:
	if !released and !entered:
		if Input.is_action_just_pressed("ui_accept"):
			released = true
			game_ref._on_knife_released(self)
	else:
		if !entered:
			position.y = position.y - 50 * speed * delta


# detectsif a body entered in the collision shape of a knife.
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Enemy" and !entered:
		
		var dup = self.duplicate()
		body.add_child(dup)
		dup.global_position = global_position
		dup.show_behind_parent = true
		dup.rotation -= body.rotation
		dup.entered = true
		queue_free()
