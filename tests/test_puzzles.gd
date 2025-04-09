extends GutTest

var PuzzleScene = preload("res://scenes/puzzlescene.tscn")
var puzzle_scene: Node
var puzzle: TileMap

func before_each() -> void:
	puzzle_scene = PuzzleScene.instantiate()
	add_child_autofree(puzzle_scene)
	
	puzzle = puzzle_scene.find_child("Puzzle", true, false)
	
	puzzle._ready()
	
	
func test_puzle_score():
	
	assert_eq(puzzle.score, 0, "puzzle score must start on 0")
	assert_eq(puzzle.turns_taken, 0, "turns taken must start on 0")


func test_number_tiles_even():
	
	var total_tiles = puzzle.board_size * puzzle.board_size
	assert_eq(total_tiles%2, 0, "amount of tiles needs to be even")
