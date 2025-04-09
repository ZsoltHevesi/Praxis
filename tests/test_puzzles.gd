extends GutTest

var PuzzleScene = preload("res://scripts/puzzle.gd")

var puzzle: TileMap

func before_each() -> void:
	puzzle = PuzzleScene.new()

	puzzle.update_text() = func(): pass
	add_child_autofree(puzzle)
	
	puzzle._ready()
	
	
func test_puzle_score():
	
	assert_eq(puzzle.score, 0, "puzzle score must start on 0")
	assert_eq(puzzle.turns_taken, 0, "turns taken must start on 0")
