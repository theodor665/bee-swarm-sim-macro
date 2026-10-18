#Requires AutoHotkey v2.0
#SingleInstance Force
SetTitleMatchMode 2
CoordMode "Mouse", "Screen"

global MacroEnabled := false

; Update these values to fit your setup.
; The window title should match the game client (example: "Roblox").
; The key presses are placeholders and can be adjusted to your gameplay flow.
global GameWindowTitle := "Roblox"
global ClickDelayMin := 150
global ClickDelayMax := 420
global FieldCycleDelayMin := 1500
global FieldCycleDelayMax := 3500

^!m::ToggleMacro()

ToggleMacro() {
    global MacroEnabled
    MacroEnabled := !MacroEnabled

    if (MacroEnabled) {
        TrayTip "Bee Swarm Macro", "Enabled — press Ctrl+Alt+M to stop.", 10, 1
        SetTimer RunMacroLoop, 250
    } else {
        TrayTip "Bee Swarm Macro", "Disabled.", 10, 1
        SetTimer RunMacroLoop, 0
    }
}

RunMacroLoop() {
    global MacroEnabled
    if (!MacroEnabled) {
        return
    }

    ; Activate the game window if it is open.
    if (WinExist(GameWindowTitle)) {
        WinActivate(GameWindowTitle)
        WinWaitActive(GameWindowTitle, , 2)
    }

    ; Example macro flow:
    ; 1) move to a collection point
    DoRandomClick(560, 310)
    Sleep RandomBetween(350, 900)

    ; 2) trigger a custom action / collect key
    SendInput "{e}"
    Sleep RandomBetween(250, 600)

    ; 3) move to a field / map area
    DoRandomClick(1040, 200)
    Sleep RandomBetween(900, 1700)

    ; 4) trigger a second action (replace with in-game keybinds you need)
    SendInput "{q}"
    Sleep RandomBetween(350, 800)

    ; 5) small extra action to keep the loop active
    SendInput "{g}"
    Sleep RandomBetween(1200, 2000)
}

RandomBetween(minVal, maxVal) {
    return minVal + (maxVal - minVal) * Random()
}

DoRandomClick(x, y) {
    x += RandomBetween(-18, 18)
    y += RandomBetween(-18, 18)
    MouseMove x, y, 15
    Sleep RandomBetween(40, 120)
    Click
}

; Optional: show a tray menu for quick control.
Menu Tray, NoStandard
Menu Tray, Add, Toggle Macro, ToggleMacro
Menu Tray, Add, Exit, ExitApp
Menu Tray, Default, Toggle Macro

ExitApp(*) {
    ExitApp
}
