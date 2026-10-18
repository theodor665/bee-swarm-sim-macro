# Bee Swarm Simulation Macro

This repository contains a starter AutoHotkey macro for a Bee Swarm Simulator-style workflow.

What is included
- `bee_swarm_macro.ahk` — a simple toggled macro script
- This README — setup notes and customization guidance

Important notes
- This is a general template, not a guaranteed working script for every game client or screen layout.
- You may need to adjust the window name, click coordinates, and keybinds to match your setup.
- Use at your own risk and only on systems/accounts you own and are allowed to automate.

How to use
1. Install AutoHotkey v2 from https://www.autohotkey.com/
2. Open `bee_swarm_macro.ahk` in AutoHotkey.
3. Update the values at the top of the script:
   - `GameWindowTitle` (example: `Roblox`)
   - the click coordinates
   - the keys used for actions such as `e`, `q`, and `g`
4. Press `Ctrl + Alt + M` to toggle the macro on/off.

Suggested customization
- Change `DoRandomClick(560, 310)` and `DoRandomClick(1040, 200)` to match your game screen layout.
- Add more actions if you want a more advanced loop.
- Add delays and randomization for better timing.

Example workflow
- click a pollen collection area
- trigger an action key
- move to a new field or route
- trigger a second action
- repeat

This file is intentionally simple so it can be adapted to your exact gameplay flow.
