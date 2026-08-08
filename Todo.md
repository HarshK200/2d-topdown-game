# DOING:
- [ ] make a rect move around
  - [x] Draw a rect *use index buffer*
  - [x] Finish projection matrix *orthogonal*
  - [x] Decide player size, internal-resolution and test-screen-resolution
    - **32x48 player size**
    - **640x360 internal render resolution**
    - **1920x1080 testing screen resolution**
  - [x] Created Arena for game memory and using temp allocator for per frame allocations
  - [ ] Create asset manager to handle texture file loading
  - [ ] Sample texture onto player's quad_mesh
  - [ ] Create input controller and handle input *use sokol's sapp input callback input*
  - [ ] Make the rect move with realtime input

# TEST:
- [ ] Maybe make the following directory structure for renderer:
    renderer/
        mesh/
            mesh2d.odin
            triagnle_mesh.odin
            quad_mesh.odin
        draw/
            player.odin
            trees.odin
            etc...
        renderer.odin

# GAME DESIGN

- TERRARIA INSPIRED BY TOP-DOWN
- 2d pixel art style
- Tilemap based desgin.
- Tiles blend smoothly FOR EXAMPLE: cakez's game Tangy TD
- Infinitly procedurally generated world
- Weapons have special effects like burn, bleed
- Combat and weapons derive the game + maybe a building system

# ART STYLE (PIXEL ART)

- [ ] Draw a basic character (no outline style, like randy)

# File Folder structure (temporary, yoinked from chatGPT)

```
src/
  main.odin
  app/
      app.odin
  game/
      game.odin
    world/
        world.odin
        tilemap.odin
    entities/
        player.odin
        enemy.odin
        bullet.odin
  renderer/
      renderer.odin
      sprite_renderer.odin
      texture.odin
  assets/
      loader.odin
      atlas.odin
  input/
      input.odin
```

# TO LEARN

- [ ] how to effeciently manage textures NOTE: watch cakez video on texture atlas or handmade hero
- [ ] nice looking pixel art particles

# TODO CORE

- [x] figure out how to setup sokol
  - [x] Build sokol static library
  - [x] Setup sokol bindings for correct intellisense
  - [x] Write the build script for as build.odin (package build)
- [x] Create a window using sokol
- [x] write a basic shader and compile it using sokol-shdc
- [x] Draw a Triangle
- [x] write a build_scripts/compile_shaders.odin which compiles all the shaders in src/shaders folder and outputs there shader_name.odin file in that folder based on platform specified as argument
- [x] Simple custom logger package
- [x] Draw rect
- [ ] Load textures/files in memory
- [ ] Upload textures/files to GPU
- [ ] how to draw texture on drawn rect, figure out shaders
- [ ] Make the drawn texture rect move
- [ ] Text rendering
- [ ] Audio processing
- [ ] Tilemap system
- [ ] Chunk loading

# TODO MISC

- [ ] Make the build script faster
  - [ ] Make use of multi threading to compile shaders and run odin build parallely (adds around 200ms without multi threading)
  - [ ] Find an alternative for process_exec() as that does stdout, stderr polling which adds around 200ms
