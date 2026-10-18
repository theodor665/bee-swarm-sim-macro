#Requires AutoHotkey v2.0
#SingleInstance Force
SetTitleMatchMode 2
CoordMode "Mouse", "Screen"

; ==========================================
; Bee Swarm Macro (AutoHotkey v2 template)
; ==========================================
; - Press F1 to toggle the macro.
; - Press F2 to open or hide the settings window.
; - Adjust values here for your game window and layout.

global MacroEnabled := false
global SettingsGui := ""
global CurrentCycle := 0

global GameWindowTitle := "Roblox"
global FocusWindowBeforeActions := true

global CollectionPoints := [
    [560, 310],
    [700, 300],
    [820, 260],
    [970, 270],
    [1080, 355],
    [910, 420]
]

global FieldPoints := [
    [1000, 200],
    [900, 245],
    [810, 290],
    [980, 360],
    [1100, 240]
]

global ActionKeys := ["{e}", "{q}", "{g}", "{f}"]

global MinClickDelayMs := 120
global MaxClickDelayMs := 420
global MinActionDelayMs := 280
global MaxActionDelayMs := 980
global MinFieldDelayMs := 1100
global MaxFieldDelayMs := 2600
global LoopDelayMs := 250

F1::ToggleMacro()
F2:: ToggleSettingsGui()

ToggleMacro() {
    global MacroEnabled
    MacroEnabled := !MacroEnabled

    if (MacroEnabled) {
        StartMacro()
    } else {
        StopMacro()
    }
}

StartMacro() {
    global MacroEnabled
    MacroEnabled := true
    TrayTip "Bee Swarm Macro", "Enabled — F1 to stop.", 10, 1
    SetTimer RunMacroLoop, LoopDelayMs
}

StopMacro() {
    global MacroEnabled
    MacroEnabled := false
    SetTimer RunMacroLoop, 0
    TrayTip "Bee Swarm Macro", "Disabled.", 10, 1
}

ToggleSettingsGui() {
    if (SettingsGui = "") {
        CreateSettingsGui()
    }

    if (WinExist("Bee Swarm Macro Settings")) {
        if (WinActive("Bee Swarm Macro Settings")) {
            SettingsGui.Hide()
        } else {
            SettingsGui.Show("AutoSize")
            WinActivate("Bee Swarm Macro Settings")
        }
    } else {
        SettingsGui.Show("AutoSize")
    }
}

RunMacroLoop() {
    global MacroEnabled
    if (!MacroEnabled) {
        return
    }

    ExecuteMacroCycle()
}

ExecuteMacroCycle() {
    global CurrentCycle, GameWindowTitle, FocusWindowBeforeActions, CollectionPoints, FieldPoints, ActionKeys

    if (FocusWindowBeforeActions) {
        TryFocusWindow(GameWindowTitle)
    }

    CurrentCycle += 1

    ; Step 1: visit a collection point
    point := CollectionPoints[RandomIndex(CollectionPoints.Length)]
    MoveAndClick(point[1], point[2])
    Sleep RandomBetween(MinClickDelayMs, MaxClickDelayMs)

    ; Step 2: trigger a random action key
    key := ActionKeys[RandomIndex(ActionKeys.Length)]
    SendInput key
    Sleep RandomBetween(MinActionDelayMs, MaxActionDelayMs)

    ; Step 3: move to a field / route focus point
    fieldPoint := FieldPoints[RandomIndex(FieldPoints.Length)]
    MoveAndClick(fieldPoint[1], fieldPoint[2])
    Sleep RandomBetween(MinFieldDelayMs, MaxFieldDelayMs)

    ; Step 4: trigger a second random action
    key2 := ActionKeys[RandomIndex(ActionKeys.Length)]
    SendInput key2
    Sleep RandomBetween(MinActionDelayMs, MaxActionDelayMs)

    ; Step 5: small idle movement to simulate active gameplay
    idlePoint := CollectionPoints[RandomIndex(CollectionPoints.Length)]
    MoveAndClick(idlePoint[1], idlePoint[2])
    Sleep RandomBetween(200, 600)

    ; Optional extra movement to keep the loop looking natural
    if (Mod(CurrentCycle, 3) = 0) {
        SendInput "{space}"
        Sleep RandomBetween(200, 500)
    }
}

TryFocusWindow(windowTitle) {
    if (WinExist(windowTitle)) {
        WinActivate(windowTitle)
        WinWaitActive(windowTitle, , 2)
    }
}

MoveAndClick(x, y) {
    x += RandomBetween(-18, 18)
    y += RandomBetween(-18, 18)
    MouseMove x, y, 12
    Sleep RandomBetween(30, 120)
    Click
}

RandomBetween(minVal, maxVal) {
    return minVal + (maxVal - minVal) * Random()
}

RandomIndex(length) {
    return Random(1, length)
}

CreateSettingsGui() {
    global SettingsGui, GameWindowTitle, FocusWindowBeforeActions, LoopDelayMs

    SettingsGui := Gui("+AlwaysOnTop +ToolWindow", "Bee Swarm Macro Settings")
    SettingsGui.SetFont("s10")
    SettingsGui.AddText(, "Game Window Title")
    SettingsGui.AddEdit("w180 vGameWindowTitle", GameWindowTitle)
    SettingsGui.AddCheckbox("vFocusWindowBeforeActions Checked", "Focus game before actions")
    SettingsGui.AddText(, "Loop Delay (ms)")
    SettingsGui.AddEdit("w180 vLoopDelayMs", LoopDelayMs)
    SettingsGui.AddButton("w80", "Apply").OnEvent("Click", ApplySettings)
    SettingsGui.AddButton("w80 x+10", "Close").OnEvent("Click", CloseSettings)
    SettingsGui.OnEvent("Close", CloseSettings)
    SettingsGui.Show("AutoSize")
}

ApplySettings(*) {
    global SettingsGui, GameWindowTitle, FocusWindowBeforeActions, LoopDelayMs, MacroEnabled

    SettingsGui.Submit()

    GameWindowTitle := SettingsGui['GameWindowTitle'].Text
    FocusWindowBeforeActions := SettingsGui['FocusWindowBeforeActions']
    LoopDelayMs := Integer(SettingsGui['LoopDelayMs'])

    if (LoopDelayMs < 100) {
        LoopDelayMs := 100
    }

    if (MacroEnabled) {
        SetTimer RunMacroLoop, 0
        SetTimer RunMacroLoop, LoopDelayMs
    }

    TrayTip "Bee Swarm Macro", "Settings saved.", 5, 1
}

CloseSettings(*) {
    global SettingsGui
    if (SettingsGui != "") {
        SettingsGui.Hide()
    }
}

Menu Tray, NoStandard
Menu Tray, Add, Toggle Macro, ToggleMacro
Menu Tray, Add, Settings, ToggleSettingsGui
Menu Tray, Add, Exit, ExitApp
Menu Tray, Default, Toggle Macro

ExitApp(*) {
    ExitApp
}

; Optional: run the settings gui immediately for convenience when script starts.
CreateSettingsGui()
TrayTip "Bee Swarm Macro", "Ready — F1 to start.", 5, 1
