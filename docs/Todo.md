# TODO CORE

- [ ] LEARN: how to effeciently manage textures NOTE: watch cakez video on texture atlas or handmade hero
- [ ] Tilemap system
- [ ] Chunk loading
- [ ] Rotation matrix
- [ ] Text rendering
- [ ] Audio processing

# TODO MISC

- [ ] Make the build script faster
  - [ ] Make use of multi threading to compile shaders and run odin build parallely (adds around 200ms without multi threading)
  - [ ] Find an alternative for process_exec() as that does stdout, stderr polling which adds around 200ms
- [ ] Particle system: Learn how to make nice looking pixel art particles


# DOING:
- [ ] Procedural world generation
    - [x] Figure out how to divide world into chunks *its basically just entity_chunk_coordinate = world_pos.xy/chunk_size.xy*
    - [ ] Tilemap system
    - [ ] Chunk loading

# DONE:
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
- [x] Load textures/files in memory
- [x] Upload textures/files to GPU
- [x] how to draw texture on drawn rect, figure out shaders
- [x] Make the drawn texture rect move
  - [x] Draw a rect *use index buffer*
  - [x] Finish projection matrix *orthogonal*
  - [x] Decide player size, internal-resolution and test-screen-resolution
    - **32x48 player size**
    - **640x360 internal render resolution**
    - **1920x1080 testing screen resolution**
  - [x] Created Arena for game memory and using temp allocator for per frame allocations
  - [x] store textures on renderer and have a reference of which which texture is used by which entity on the entity for e.g.

        ```player.sprite.texture_id```

  - [x] Sample texture onto player's quad_mesh
  - [x] Create input controller and handle input *use sokol's sapp input callback input*
  - [x] Make the player rect move with realtime input



# EXPERIMENT:
- [x] Maybe make the following directory structure for renderer:
```
    renderer/
        renderer.odin
        mesh/
            mesh2d.odin
            triagnle_mesh.odin
            quad_mesh.odin

        draw/               // Dropped draw dir since it uses the renderer avoids ciruclar dep
            player.odin
            trees.odin
            etc...
```


# GAME DESIGN **TODO: (Make a different md file for game design doc)**

- **CORE GAMELOOP: Combat, weapons drops, loot, dungeon explore, GOAL: kill demon king**
- World inspired by Terraria
    - World gets generated once using procedural noise techniques *multiple passes* and saved to file
    - Hand drawn structures are placed via procedural generation
    - 3 Major continents (Human, elf & Demon) each level rising with difficulty
    - Around 50 weapons
        - Only 5 to 10 different weapon classes
        - Rest approx 40 Weapons have special effects like burn, bleed
- Art direction
    - 2d topdown pixel art style
    - No outline characters and items (for eg: *Terrafactor* by Randy)
    - Tilemap tiles blend smoothly (for eg: *Tangy TD* by cakez's game )


# File Folder structure

```
assets/
    texture/
src/
    main.odin
    app/
        app.odin
    game/
        game.odin
        player.odin
        enemy.odin
        world/
            world.odin
            tilemap.odin
    input/
        input.odin
    renderer/
        mesh/
        renderer.odin
        texture.odin
    shaders/
        default.glsl
    utils/
        constant.odin
        core.odin
```

# Modules dependency graph (follows seperation of concerns)

APP ---Ownes--> Game
APP ---Ownes--> Renderer
APP ---Ownes--> Input

utils ---Read only access---> Renderer, Game, Input, *all
Game ---Read only access---> Renderer
Input ---Read only access---> Game
