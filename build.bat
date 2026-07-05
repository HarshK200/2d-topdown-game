@echo off
setlocal

REM =========== Constants ===========
set "PROJECT_DIR=."
set "RELEASE_BUILD_DIR=build/release"
set "DEBUG_BUILD_DIR=build/debug"

REM =========== Parse arguments ===========
set "BUILD_FLAGS="
set "TARGET_DIR="

if "%~1"=="--debug" (
    echo Building debug...
    set "TARGET_DIR=%DEBUG_BUILD_DIR%"
    set "BUILD_FLAGS=-debug"

) else if "%~1"=="--release" (
    echo Building release...
    set "TARGET_DIR=%RELEASE_BUILD_DIR%"
    set "BUILD_FLAGS=-o:speed -no-bounds-check -disable-assert"

) else if "%~1"=="" (
    echo Building release...
    set "TARGET_DIR=%RELEASE_BUILD_DIR%"
    set "BUILD_FLAGS=-o:speed -no-bounds-check -disable-assert"

) else (
    echo Invalid argument %~1
    exit /b 2
)

REM ========= Clean previous build =========
if exist "%TARGET_DIR%" (
    echo Cleaning previous %TARGET_DIR% dir...
    rmdir /s /q "%TARGET_DIR%"
)

mkdir "%TARGET_DIR%"

REM ========== Build ==========
echo Running build command:
echo odin build "%PROJECT_DIR%" -out:"%TARGET_DIR%/main.exe" %BUILD_FLAGS%

odin build "%PROJECT_DIR%" -out:%TARGET_DIR%/main.exe %BUILD_FLAGS%

exit /b %ERRORLEVEL%
