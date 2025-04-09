extends TileMap



@onready var instructions_screen = get_tree().get_current_scene().find_child("InstructionsScreen", true, false)
var board_size = 4
enum Layers{hidden,revealed}
var SOURCE_NUM = 0
const hidden_tile_coords = Vector2(9,0)
const hidden_tile_alt = 1
var revealed_spots = []
var tile_pos_to_atlas_pos = {}
var score = 0
var turns_taken = 0
@onready var win_screen = get_tree().get_current_scene().find_child("Winscreen", true, false)
@onready var puzzle_scene = get_parent()
const SAVE_FILE_PATH = "user://high_score.save"





# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup_board()
	update_text()


func get_tiles_to_use():
	var chosen_tile_coords = []
	var options = range(10)
	options.shuffle()
	for i in range(board_size * int(board_size / 2)):
		var current = Vector2(options.pop_back(), 1)
		for j in range(2):
			chosen_tile_coords.append(current)
	chosen_tile_coords.shuffle()
	return chosen_tile_coords

func setup_board():
	var cards_to_use = get_tiles_to_use()
	for y in range(board_size):
		for x in range(board_size):
			var current_spot = Vector2(x, y)
			place_single_face_down_card(current_spot)
			var card_atlas_coords = cards_to_use.pop_back()
			tile_pos_to_atlas_pos[current_spot] = card_atlas_coords
			self.set_cell(Layers.revealed, current_spot, 
						SOURCE_NUM, card_atlas_coords)


func place_single_face_down_card(coords: Vector2):
	self.set_cell(Layers.hidden, coords, 
				SOURCE_NUM, hidden_tile_coords, hidden_tile_alt)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			var global_clicked = event.position
			var pos_clicked = Vector2(local_to_map(to_local(global_clicked)))
			print(pos_clicked)
			var current_tile_alt = get_cell_alternative_tile(Layers.hidden, pos_clicked)
			if current_tile_alt == 1 and revealed_spots.size() < 2:
				self.set_cell(Layers.hidden, pos_clicked, -1)
				revealed_spots.append(pos_clicked)
				if revealed_spots.size() == 2:
					when_two_cards_revealed()


func when_two_cards_revealed():
	if tile_pos_to_atlas_pos[revealed_spots[0]] == tile_pos_to_atlas_pos[revealed_spots[1]]:
		score += 1
		revealed_spots.clear()
		check_win_condition()
	else:
		put_back_cards_with_delay()
	turns_taken += 1
	update_text()


func check_win_condition():
	var total_pairs = int((board_size * board_size) / 2)
	if score == total_pairs:
		show_win_screen()
		
func show_win_screen():
	win_screen.visible = true
	puzzle_scene.visible = false

	var previous_best = load_high_score()

	# Check if this is a new best score (lower turns = better)
	if previous_best == -1 or turns_taken < previous_best:
		save_high_score()
		previous_best = turns_taken  # update display
		
	# Update labels on the win screen
	var score_label = win_screen.get_node("final_score_label")
	var turns_label = win_screen.get_node("final_turns_label")
	var high_score_label = win_screen.get_node("final_high_score_label")  # <-- add this node in your scene

	if score_label:
		score_label.text = "Final Score: %d" % score
	if turns_label:
		turns_label.text = "Turns Taken: %d" % turns_taken
	if high_score_label:
		high_score_label.text = "Best Score (Lowest Turns): %d" % previous_best


func load_high_score() -> int:
	if FileAccess.file_exists(SAVE_FILE_PATH):
		var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
		var saved_score = file.get_var()
		file.close()
		return saved_score
	else:
		return -1  # No saved score yet




func update_text():
	$"../CanvasLayer/score_label".text = "Score: %d" % score
	$"../CanvasLayer/turns_label".text = "Turns Taken: %d" % turns_taken

	var best_score = load_high_score()
	if best_score != -1:
		$"../CanvasLayer/best_score_label".text = "Best Score (Lowest Turns): %d" % best_score
	else:
		$"../CanvasLayer/best_score_label".text = "Best Score (Lowest Turns): N/A"




func put_back_cards_with_delay():
	await self.get_tree().create_timer(1.5).timeout
	for spot in revealed_spots:
		place_single_face_down_card(spot)
	revealed_spots.clear()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_again_button_pressed():
	get_tree().reload_current_scene()
	
	
func save_high_score():
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	file.store_var(turns_taken)
	file.close()



func _on_backhome2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu2.tscn")


func _on_back_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu2.tscn")


func _on_close_button_pressed():
	if instructions_screen:
		instructions_screen.visible = false
