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

    UpdateTrayItems()
}

TrayCallback(ItemName, ItemPos, Menu) {
    UpdateTrayItems()
}

UpdateTrayItems() {
    global isCoffeeHot
    global trayMenu

    if isCoffeeHot {
        trayMenu.Enable("Disable")
        trayMenu.Disable("Enable")
    } else {
        trayMenu.Enable("Enable")
        trayMenu.Disable("Disable")
    }
}

StartCoffee(*) {
    global isCoffeeHot

    isCoffeeHot := 1
    UpdateTrayItems()
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
    UpdateTrayItems()
}

ExitAppCallback(*) {
    ExitApp
}
