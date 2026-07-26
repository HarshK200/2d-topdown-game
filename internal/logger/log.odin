package logger

import "base:runtime"
import "core:fmt"
import "core:os"
import "core:path/filepath"

@(private)
ESC :: "\x1b["

@(private)
Debug_Color :: ESC + "1;38;5;250m"

@(private)
Info_Color :: ESC + "1;38;5;255m"

@(private)
Warn_Color :: ESC + "1;38;5;222m"

@(private)
Error_Color :: ESC + "1;38;5;210m"

@(private)
Reset :: ESC + "0m"

Level :: enum {
	Debug = 0,
	Info  = 1,
	Warn  = 2,
	Error = 3,
}

LoggerConfig :: struct {
	UseColors:     bool,
	Minimum_Level: Level,
}

@(private)
_config: LoggerConfig

init :: proc(cfg: LoggerConfig = {UseColors = true, Minimum_Level = Level.Info}) {
	_config = cfg
}

// ===================== helpers =====================

@(private)
_log :: proc(
	level_str: string,
	color_str: string,
	loc := #caller_location,
	use_loc: bool = true,
	text: string,
) {
	if (_config.UseColors) {
		if (use_loc) {
			fmt.printfln(
				"%s%s%s %s %s",
				color_str,
				level_str,
				Reset,
				_get_caller_base_loc(loc),
				text,
			)
		} else {
			fmt.printfln("%s%s%s %s", color_str, level_str, Reset, text)
		}
	} else {
		if (use_loc) {
			fmt.printfln("%s %s %s", level_str, _get_caller_base_loc(loc), text)
		} else {
			fmt.printfln("%s %s", level_str, text)
		}
	}
}
@(private)
_get_caller_base_loc :: proc(location := #caller_location) -> string {
	filename := filepath.base(location.file_path)

	return fmt.tprintf("[%s:%d:%d]", filename, location.line, location.column)
}


// ===================== DEBUG =====================

// NOTE: make sure you have called init() to configure logger
debug :: proc(text: string, location := #caller_location) {
	if (Level.Debug < _config.Minimum_Level) {return}

	_log("[DEBUG]", Debug_Color, location, true, text)
}

// NOTE: make sure you have called init() to configure logger
debugf :: proc(format_str: string, args: ..any, location := #caller_location) {
	debug(fmt.tprintf(format_str, ..args), location)
}


// ===================== INFO =====================

// NOTE: make sure you have called init() to configure logger
info :: proc(text: string, location := #caller_location) {
	if (Level.Info < _config.Minimum_Level) {return}

	_log("[INFO ]", Info_Color, location, false, text)
}

// NOTE: make sure you have called init() to configure logger
infof :: proc(format_str: string, args: ..any, location := #caller_location) {
	info(fmt.tprintf(format_str, ..args), location)
}


// ===================== WARN =====================

// NOTE: make sure you have called init() to configure logger
warn :: proc(text: string, location := #caller_location) {
	if (Level.Warn < _config.Minimum_Level) {return}

	_log("[WARN ]", Warn_Color, location, true, text)
}

// NOTE: make sure you have called init() to configure logger
warnf :: proc(format_str: string, args: ..any, location := #caller_location) {
	warn(fmt.tprintf(format_str, ..args), location)
}


// ===================== ERROR =====================

// NOTE: make sure you have called init() to configure logger
error :: proc {
	error_str,
	error_err,
}
@(private)
error_str :: proc(text: string, location := #caller_location) {
	if (Level.Error < _config.Minimum_Level) {return}

	_log("[ERROR]", Error_Color, location, true, text)
}
@(private)
error_err :: proc(err: ..any, location := #caller_location) {
	if (Level.Error < _config.Minimum_Level) {return}

	_log(" [ERROR]", Error_Color, location, true, fmt.aprint(..err, sep = " "))
}

// NOTE: make sure you have called init() to configure logger
errorf :: proc(format_str: string, args: ..any, location := #caller_location) {
	error(fmt.tprintf(format_str, ..args), location)
}
