#!/bin/bash

# CONSTANTS
PROJECT_DIR="."
RELEASE_BUILD_DIR="build/release"
DEBUG_BUILD_DIR="build/debug"

# input arguments
build_mode=$1 # could be release or debug

build_flags=()
target_dir=""

if [[ "$build_mode" == "--debug" ]]; then
    echo "Building debug..."
    target_dir=$DEBUG_BUILD_DIR
    build_flags+=("-debug")

elif [[ "$build_mode" == "--release" || -z "$build_mode" ]]; then
    echo "Building release..."
    target_dir=$RELEASE_BUILD_DIR
    build_flags+=("-o:speed" "-no-bounds-check" "-disable-assert")

else
    echo "Invalid argument $1" >&2
    exit 2
fi

build_command=("odin" "build" "$PROJECT_DIR" "-out:$target_dir/main.exe")
build_command+=("${build_flags[@]}") # add build flags set based on build mode

if [[ -d "$target_dir" ]];then
    echo "Cleaning previous $target_dir dir..."
    rm -rf "$target_dir"
fi

mkdir -p $target_dir

echo "Running build command: ${build_command[*]}"
"${build_command[@]}"
