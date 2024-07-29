extends CharacterBody3D

@onready var navigation_agent : NavigationAgent3D = $NavigationAgent3D
@onready var goal_lists : Node = $GoalManager
@onready var action_lists : Node = $ActionManager
@onready var goals = goal_lists.get_children()
@onready var target_raycast : RayCast3D = $TargetRayCast

var _goal
var _plan
var _plan_step
var SPEED = 1.4
var ACCELERATION = 1.0
var SPEED_MODIFIER = 1.0
@export var states : Dictionary
var state = {
	"is_near_target" = false,
	"is_target_visible" = false,
	"is_aimed" = false,
	"is_hiding" = false,
	"low_health" = false,
	"can_shoot" = true,
	"is_in_animation" = false
}

func _physics_process(delta):
	move_and_slide()

func _process(delta):
	var goal = get_best_goal()
	if state["is_in_animation"] == false:
		if goal != _goal || _goal == null:
			_goal = goal
			# This blackboard are used to store information used for creating plans,
			# every current state will be saved inside this blackboard
			# but information other that the states could be included
			var blackboard = {
				"position" : position,
				"health" : $Health.health
				#"target_position" : $Detection._target.position
			}
			for s in state:
				blackboard[s] = state[s]
			
			if _goal != null:
				_plan = get_plan(_goal,blackboard)
			_plan_step = 0
			print(goal)
			print(blackboard)
			print(_plan)
		elif _goal != null:
			follow_plan(_plan,delta)

func follow_plan(plan,delta):
	#if state["is_in_animation"] == false: #plan will be halted if animation is playing
	if plan.size() == 0:
		return
	

	var is_step_complete = plan[_plan_step].execute(delta)
	if is_step_complete and _plan_step < plan.size() - 1:
		print("action completed")
		_plan_step += 1
	elif is_step_complete && _plan_step == plan.size() - 1:
		print("goal completed")
		_goal = null

func get_best_goal():
	#if best_goal == null || best_goal != _goal
	var best_goal
	for i in goals:
		if i.validity() == true and (best_goal == null or i.priority() > best_goal.priority()):
			best_goal = i
	return best_goal

func get_plan(goal,blackboard):
	var desired_state = goal.desired_state()
	if desired_state.is_empty():
		return []
	return find_best_plan(goal,desired_state,blackboard)

func find_best_plan(goal,desired_state,blackboard):
	var root = {
		"action" : goal,
		"state" : desired_state,
		"children" : []
	}
	
	if create_plans(root,blackboard.duplicate()):
		var plans = plan_tree_into_array(root,blackboard)
		print(plans)
		return get_cheapest_plan(plans)
	return []

	# get cheapest plan from plan_tree_into_array()
func get_cheapest_plan(plans):
	var cheapest_plan
	for plan in plans:
		if cheapest_plan == null || plan.cost < cheapest_plan.cost:
			cheapest_plan = plan
	return cheapest_plan.actions

func create_plans(plan,blackboard):
	var repeat = false #for looping the function over again
	
	# every node in the tree will have its own state for the action to satisfy
	var node_state = plan.state.duplicate()
	
	# checks the blackboard for state that can be satisfy
	for state in plan.state:
		if node_state[state] == blackboard.get(state):
			node_state.erase(state)
	
	# if there's no state left, that means the planner already satisfy all the state requirement
	if node_state.is_empty():
		return true
	
	# loops all available action
	for action in action_lists.get_children():
		var could_use_action = false
		var node_desired_state = node_state.duplicate()
		var action_desired_state = action.desired_state()
		for s in node_desired_state:
			if node_desired_state[s] == action_desired_state.get(s):
				action_desired_state.erase(s)
				could_use_action = true
		
		# compare all the state to if it can be used or not
		if could_use_action:
			var required_states = action.required_state()
			for state in required_states:
				action_desired_state[state] = required_states[state]
			
			var a = {
				"action" = action,
				"state" = action_desired_state,
				"children" = []
			}
			
			# if desired state is empty, the action will be included
			# if it isnt empty this function will be called again recursively
			# every action will be checked to satisfy all the desired state
			if action_desired_state.is_empty() || create_plans(a,blackboard.duplicate()):
				plan.children.push_back(a)

				repeat = true
	return repeat

func plan_tree_into_array(plan,blackboard):
	var plans = []
	
	if plan.children.size() == 0:
		plans.push_back({"actions": [plan.action], "cost": plan.action.get_cost(blackboard)})
	
	for p in plan.children:
		for child_plan in plan_tree_into_array(p, blackboard):
			if plan.action.has_method("get_cost"):
				print(plan)
				child_plan.actions.push_back(plan.action)
				child_plan.cost += plan.action.get_cost(blackboard)
			plans.push_back(child_plan)
	return plans
