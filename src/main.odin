package main

import "topdown_game:internal/logger"
import "topdown_game:src/app"

main :: proc() {
	logger.init({UseColors = true, Minimum_Level = logger.Level.Debug})

	app.run()
}
