class_name StateMachine
extends Node

@export var initial_state: State
var current_state: State
var states: Dictionary = {}

enum State {
	IDLE,
	RUN,
	JUMP,
	DOUBLE_JUMP,
	CLIMB,
	KNOCKEDBACK
}

func _ready():
	for child in get_children():
		states[child.state] = child
		child.state_changed.connect(_on_changed_state)
		
	current_state = initial_state
	_on_changed_state(current_state.state)

func _process(delta):
	if current_state:
		current_state.update(delta)
		
func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)
		
func _on_changed_state(new_state: int) -> void:
	var changed_state = states[new_state]
	if not changed_state:
		return
		
	current_state.exit()
	changed_state.enter()
	current_state = changed_state
