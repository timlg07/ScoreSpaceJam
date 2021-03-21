extends Spatial

onready var gui := $GUI
var score := 0
var streak := 0

var body

var spawn_interval := 0.5
var time := 0.0
onready var spawn_points := get_tree().get_nodes_in_group("SpawnPoint")

var red_puzzle := preload("res://scenes/Red_Puzzle.tscn")
var blue_puzzle := preload("res://scenes/Blue_Puzzle.tscn")
var yellow_puzzle := preload("res://scenes/Yellow_Puzzle.tscn")
var puzzles := [red_puzzle,blue_puzzle,yellow_puzzle]

func _process(delta):
	time += delta
	if time > spawn_interval:
		time -= spawn_interval
		_spawn_puzzle()
	

func _ready() -> void:
	body = get_node("player/helper_z/helper_x/bodyhelper/body")
	body.connect("puzzle_collected", self, "_on_collect")

func _on_collect(changed: bool) -> void:
	if changed:
		if streak >0:
			score += pow(2,streak-1)
			gui.set_score(score) 
		streak = 0
	else:
		streak +=1
		if streak >= 8:
			score += pow(2,streak-1)
			gui.set_score(score)
			streak = 0
			body.set_default_color()
	gui.set_streak(streak)

func _spawn_puzzle() -> void:
	randomize()
	var random = floor(rand_range(0.0, spawn_points.size()))
	randomize()
	var random_piece = floor(rand_range(0.0, puzzles.size()))
	var instance = puzzles[random_piece].instance()
	instance.set_transform(spawn_points[random].global_transform)
	add_child(instance)


func _on_body_tree_exited():
	gui.show_gameOver(score)