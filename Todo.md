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
  game/
      game.odin
  render/
      renderer.odin
      sprite_renderer.odin
      texture.odin
  world/
      world.odin
      tilemap.odin
  entities/
      player.odin
      enemy.odin
      bullet.odin
  assets/
      loader.odin
      atlas.odin
  math/
      camera.odin
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

- [ ] write a build_scripts/compile_shaders.odin which compiles all the shaders in src/shaders folder and outputs there shader_name.odin file in that folder based on platform specified as argument

- [ ] Draw rect
- [ ] Load textures/files in memory
- [ ] Upload textures/files to GPU
- [ ] how to draw texture on drawn rect, figure out shaders
- [ ] Make the drawn texture rect move
- [ ] Text rendering
- [ ] Audio processing
- [ ] Tilemap system
- [ ] Chunk loading
