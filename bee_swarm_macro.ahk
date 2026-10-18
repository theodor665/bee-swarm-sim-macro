# Bee Swarm Simulation Macro

This repository contains a more complete AutoHotkey template for a Bee Swarm Simulator-style automation loop.

Included files
- `bee_swarm_macro.ahk` — a toggled macro with settings UI, random movement, action keys, and timing controls
- `README.md` — quick setup and customization notes

Important notes
- This is a template, not a guaranteed working script for every screen layout, game build, or client setup.
- You may need to adjust the window title, click coordinates, and keybinds to match the exact gameplay flow you want.
- Use only on machines and accounts you own and are allowed to automate.
- This script is meant to be an example foundation for your own workflow.

How to use
1. Install AutoHotkey v2 from https://www.autohotkey.com/
2. Open `bee_swarm_macro.ahk` with AutoHotkey.
3. Edit the values near the top of the script:
   - `GameWindowTitle`
   - `CollectionPoints`
   - `FieldPoints`
   - `ActionKeys`
   - timing values such as `MinActionDelayMs` and `MaxFieldDelayMs`
4. Press `Ctrl + Alt + M` to toggle the macro on/off.
5. Press `Ctrl + Alt + S` to open the settings window.

What the script does
- focuses the game window when enabled
- picks random collection positions and clicks them
- sends random action keys such as `e`, `q`, `g`, and `f`
- cycles through field points to simulate active play
- uses randomized timing to make the loop look more natural
- exposes a small settings panel for tweaking the base loop

Recommended workflow for adaptation
- Replace or expand `CollectionPoints` and `FieldPoints` with your actual in-game click positions.
- Replace `ActionKeys` with the keys you use for harvesting, traversing, or interacting with the game.
- Tune the delays to avoid too-fast or too-robotic actions.
- If your game uses different keybindings or windows, update those before running the script.

This project is intentionally a flexible starter and should be adjusted to your exact setup before use.

Example quick-start edits
- `GameWindowTitle := "Roblox"`
- `CollectionPoints := [[560, 310], [700, 300], [820, 260]]`
- `ActionKeys := ["{e}", "{q}", "{g}"]`
- `MinFieldDelayMs := 1100`
- `MaxFieldDelayMs := 2600`

If you want a more specialized setup later, this template can be expanded to support:
- auto-harvesting loops
- auto-egg collection
- field switching
- a GUI with saved profiles
- click-to-reposition calibration

