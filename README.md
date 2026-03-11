# Wave Function Collapse

A tile-based procedural map generator built with **Godot 4.2** (GDScript), implementing the [Wave Function Collapse](https://github.com/mxgmn/WaveFunctionCollapse) algorithm.

## How It Works

The algorithm generates a grid of tiles by iteratively collapsing cells with the lowest entropy (fewest remaining valid states) and propagating constraints to neighboring cells. Each tile defines edge compatibility rules so that adjacent tiles always produce coherent results.

**Core classes:**

| Class | Role |
|-------|------|
| `Wave` | Maintains the grid of cells, drives iteration (observe → propagate) |
| `Cell` | Tracks possible tile states; collapses to a single state during observation |
| `Tile` | Defines atlas coordinates, rotation, and per-edge compatibility labels |
| `Compat` | Builds the full compatibility matrix from tile edge definitions |
| `TileMap` | Renders the collapsed wave onto a Godot `TileMap` node |

**Tile types:** inner wall, air, edges (4 rotations), corners (4 rotations), and inner corners (4 rotations) — 14 tile variants total, with weighted random selection favoring open space.

## Controls

| Input | Action |
|-------|--------|
| `Space` / `Enter` | Generate a new map |
| `W` `A` `S` `D` | Pan the camera |
| Scroll up / down | Zoom in / out |

## Running the Project

1. Install [Godot 4.2+](https://godotengine.org/download) (standard or .NET).
2. Clone this repository:
   ```
   git clone https://github.com/wirelesschipmunk/Wave-Function-Collapse.git
   ```
3. Open the project in Godot (`project.godot`).
4. Press **F5** (or the Play button) to run.

## Export

Pre-configured export presets are included for **Windows** and **Linux x86_64**. Use *Project → Export* in the Godot editor to build.

## License

See the repository for license details.
