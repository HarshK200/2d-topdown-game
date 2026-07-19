**This project uses the following odin version: _dev-2026-06-nightly:7ab61e4_**

# This project is a game, not a game engine.

- **Systems exist to separate responsibilities, not to create reusable APIs.**
- **Prefer explicit code over generic abstractions.**
- **Introduce a new subsystem only when it has a distinct responsibility (renderer, app, game, assets), not because a pattern says it should exist.**
- **If a function is only ever used by this game, it's perfectly fine for it to be specific to this game.**
