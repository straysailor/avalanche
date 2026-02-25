extends Control

@onready var label = $ClockFace

var time_elapsed : float = 0.0
var is_stopped : bool = false

func _ready() -> void:
	print("Timer started!")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !is_stopped:
		time_elapsed += delta
		label.text = str(time_elapsed).pad_decimals(2)

func star_timer() -> void:
	is_stopped = false
