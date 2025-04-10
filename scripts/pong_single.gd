extends Control

@onready var game_over_screen = $GameOverScreen/GameOverScreen
@onready var go_score = $GameOverScreen/GameOverScreen/goScore
@onready var go_high_score = $GameOverScreen/GameOverScreen/goHighScore

@onready var scoreLabel = $canvasBackground/score
@onready var highScoreLabel = $canvasBackground/highScore

@onready var trophy = $GameOverScreen/GameOverScreen/Trophy

var score = 0
var high_score = 0
var previous_high_score = 0

func _ready() -> void:
	# Reference the Area2D nodes
	var top_scoring_area = $LoseTop
	var bottom_scoring_area = $LoseBottom
	
	load_high_score()
	previous_high_score = high_score

	# Connect the body_entered signals to the scoring function
	top_scoring_area.connect("body_entered", Callable(self, "_on_ScoringArea_body_entered"))
	bottom_scoring_area.connect("body_entered", Callable(self, "_on_ScoringArea_body_entered"))

	# Set the size and position of the scoring areas
	var screen_size = get_viewport_rect().size
	top_scoring_area.position = Vector2(screen_size.x / 2, screen_size.y / 24)
	bottom_scoring_area.position = Vector2(screen_size.x / 2, screen_size.y * 23 / 24)

	var top_shape = top_scoring_area.get_node("CollisionShape2D").shape as RectangleShape2D
	var bottom_shape = bottom_scoring_area.get_node("CollisionShape2D").shape as RectangleShape2D

	top_shape.extents = Vector2(screen_size.x / 2, screen_size.y / 24)
	bottom_shape.extents = Vector2(screen_size.x / 2, screen_size.y / 24)

	# Load the high score
	load_high_score()

	# Update the high score label
	update_high_score_label()

func _on_ScoringArea_body_entered(body: Node) -> void:
	if body is CharacterBody2D:
		get_tree().paused = true
		game_over_screen.visible = true
		# Update the scores
		update_scores()
		# Check and update the high score
		if score > high_score:
			high_score = score
			save_high_score()
		update_high_score_label()
		if high_score > previous_high_score:
			trophy.visible = true

func update_scores():
	go_score.text = "Score: %d" % score
	scoreLabel.text = "Score: %d" % score
	if score > high_score:
		high_score = score
		save_high_score()
		load_high_score()
		update_high_score_label()

func update_high_score_label():
	go_high_score.text = "High Score: %d" % high_score
	highScoreLabel.text = "High Score: %d" % high_score

func save_high_score():
	var file = FileAccess.open("user://pong_lvl1_high_score.save", FileAccess.WRITE)
	file.store_var(high_score)
	file.close()

func load_high_score():
	var file = FileAccess.open("user://pong_lvl1_high_score.save", FileAccess.READ)
	if file:
		high_score = file.get_var()
		file.close()
	else:
		high_score = 0


func _on_back_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu3.tscn")


func _on_play_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/pong_single.tscn")
