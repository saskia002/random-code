#Requires AutoHotkey v2.0
#SingleInstance Force
Persistent
;SetBatchLines -1

isCoffeeHot := 0
trayMenu := A_TrayMenu

BuildTrayMenu()

BuildTrayMenu() {
    global trayMenu

    trayMenu.Delete()
    trayMenu.Add("Enable", StartCoffee)
    trayMenu.Add("Disable", StopCoffee)
    trayMenu.Add("")
    trayMenu.Add("Exit", ExitAppCallback)
    trayMenu.ClickCallback := TrayCallback

    UpdateTray()
}

TrayCallback(ItemName, ItemPos, Menu) {
    UpdateTray()
}

UpdateTray() {
    global isCoffeeHot
    global trayMenu

    onIcon := A_ScriptDir "\icon\coffee_on.ico"
    offIcon := A_ScriptDir "\icon\coffee_off.ico"

    if isCoffeeHot {
        trayMenu.Enable("Disable")
        trayMenu.Disable("Enable")

        TraySetIcon(onIcon)
    } else {
        trayMenu.Enable("Enable")
        trayMenu.Disable("Disable")

        TraySetIcon(offIcon)
    }
}

UpdateTrayIcon() {
    global isCoffeeHot

    ; Paths to your icons, change paths as needed:
    onIcon := A_ScriptDir "\coffee_on.ico"
    offIcon := A_ScriptDir "\coffee_off.ico"

    if isCoffeeHot {
        trayMenu.SetIcon("", onIcon)  ; Change tray icon to coffee_on.ico
    } else {
        trayMenu.SetIcon("", offIcon) ; Change tray icon to coffee_off.ico
    }
}

StartCoffee(*) {
    global isCoffeeHot

    isCoffeeHot := 1
    UpdateTray()
    loop {
        if !isCoffeeHot {
            break
        }
        Send "{F22}"
        Sleep 30000
    }
}

StopCoffee(*) {
    global isCoffeeHot

    isCoffeeHot := 0
    UpdateTray()
}

ExitAppCallback(*) {
    ExitApp
}
