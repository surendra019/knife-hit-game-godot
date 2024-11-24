extends Control


@onready var knife_spawn_point: Marker2D = $KnifeSpawnPoint
@onready var knife_slot_container: VBoxContainer = $MarginContainer/KnifeSlotContainer

const KNIFE = preload("res://Scenes/knife.tscn")
const GAME_KNIFE_ICON = preload("res://Scenes/game_knife_icon.tscn")

var knife_count: int = 10

func _ready() -> void:
	spawn_knife()
	add_knife_slots()

# adds knife slots in the knife slot container.
func add_knife_slots() -> void:
	for i in knife_count:
		var knife_slot = GAME_KNIFE_ICON.instantiate()
		knife_slot_container.add_child(knife_slot)
	
# spawns a new knife at the knife spawn point.
func spawn_knife() -> void:
	var knife = KNIFE.instantiate()
	add_child(knife)
	knife.position = knife_spawn_point.position

# returns true if there is a knife available.
func is_knife_available() -> bool:
	return knife_count > 0

# returns the available knife index in the parent.
func get_available_knife_slot() -> int:
	for i in knife_slot_container.get_child_count():
		var child = knife_slot_container.get_children()[i]
		if child.current_state == child.STATE.FULL:
			return i
	return -1
		

# called when the knife is released.
func _on_knife_released(knife: Node2D) -> void:
	if is_knife_available():
		knife_count -= 1
		var knife_slot_idx = get_available_knife_slot()
		knife_slot_container.get_child(knife_slot_idx).set_current_state(knife_slot_container.get_child(knife_slot_idx).STATE.EMPTY)
		if knife_count != 0:
			spawn_knife()
	else:
		print("game over")
		
	
