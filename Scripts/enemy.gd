extends RigidBody2D

@onready var timer: Timer = $Timer

var difficulty: int = 3
var can_lerp: bool

func _ready() -> void:
	timer.wait_time = randf_range((1 / difficulty * 10) * randf_range(1, 2), 5)
	change_angular_velocity()

# changes the angular velocity when called to a random value.
func change_angular_velocity():
	angular_velocity = randf_range(-difficulty * 2, difficulty * 2)

func _process(delta: float) -> void:
	if can_lerp:
		var values = [0, randf_range(0, difficulty)]
		angular_velocity = lerp(angular_velocity, float(values.pick_random()), .15)

func _on_timer_timeout() -> void:
	can_lerp = [true, false].pick_random()
	if !can_lerp:
		change_angular_velocity()
	timer.wait_time = randf_range((1 / difficulty * 10) * randf_range(1, 2), 5)
	timer.start()
	
