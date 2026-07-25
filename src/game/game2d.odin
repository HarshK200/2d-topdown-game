package game

import "topdown_game:internal/logger"

Game2D :: struct {}

init :: proc(game: ^Game2D) {
	logger.info("Initializing game... *lol this is empty*")
}

update :: proc(game: ^Game2D) {}

cleanup :: proc(game: ^Game2D) {}
